# التصميم التقني (Architecture), النسخة 0.1

## 1. التقنيات المختارة وليه

| الجزء | الاختيار | ليه |
|---|---|---|
| تطبيق الموبايل | **Flutter (Dart)** | كود واحد يطلع Android و iOS، ودعم ممتاز للعربي من اليمين للشمال |
| إدارة الحالة | **Riverpod** | بسيط وقوي وسهل يتعمله اختبارات |
| التنقل بين الشاشات | **go_router** | يدعم توجيه المستخدم حسب دوره وروابط عميقة |
| الترجمة | **flutter gen-l10n** (ملفات ARB) | الطريقة الرسمية في Flutter |
| السيرفر وقاعدة البيانات | **Supabase** (PostgreSQL) | الداتا علاقات (مدرس ← مجموعات ← طلبة ← أولياء أمور) وده مناسب لقاعدة بيانات SQL أكتر من Firebase، وفيه Row Level Security للأمان، وتسجيل دخول وتخزين ملفات، وبيبدأ ببلاش |
| الإشعارات | **Firebase Cloud Messaging** | الأساسي للإشعارات على Android و iOS |
| الدفع (ويب) | **Paymob / Fawry** في مصر، **Tap / HyperPay** في الخليج | الطرق المحلية والمحافظ الإلكترونية |
| الدفع جوه التطبيق | **RevenueCat** | بيوحد اشتراكات آبل وجوجل |
| الذكاء الاصطناعي (المرحلة 3) | Claude API عن طريق Supabase Edge Function | المفتاح يفضل على السيرفر ومايبقاش جوه التطبيق |

## 2. هيكل المشروع (Feature-first)

```
teacher-app/
├── lib/
│   ├── main.dart
│   ├── app.dart                 # MaterialApp + اللغة + الثيم
│   ├── core/
│   │   ├── l10n/                # ملفات الترجمة app_ar.arb و app_en.arb
│   │   ├── router/              # go_router وتوجيه حسب الدور
│   │   ├── theme/               # الألوان والخطوط
│   │   └── settings/            # اللغة المختارة
│   └── features/
│       ├── auth/                # تسجيل الدخول واختيار الدور
│       ├── teacher/             # لوحة المدرس والمجموعات وبنك الأسئلة
│       ├── student/             # لوحة الطالب والحل
│       ├── parent/              # لوحة ولي الأمر
│       ├── assessments/         # الامتحانات والواجبات (مشتركة)
│       └── billing/             # الاشتراكات
├── test/
└── docs/
```

## 3. قاعدة البيانات (الجداول الأساسية)

```
profiles            (id, full_name, phone, email, locale, country, created_at)
user_roles          (user_id, role: teacher|student|parent|assistant)

teachers            (user_id, subjects[], curricula[], billing_mode: teacher_pays|student_pays)
groups              (id, teacher_id, name, grade, curriculum, schedule jsonb,
                     location, monthly_fee, currency, invite_code, auto_approve)
group_members       (group_id, student_id, status: pending|active|left, joined_at)
parent_links        (parent_id, student_id, status: pending|verified)
assistants          (teacher_id, assistant_id, permissions jsonb)        -- المرحلة 2

questions           (id, teacher_id, type: mcq|true_false|short|essay, body, media_url,
                     options jsonb, correct_answer jsonb, chapter, difficulty, tags[])
assessments         (id, teacher_id, group_id, kind: homework|quiz|exam, title,
                     opens_at, closes_at, duration_min, shuffle_questions,
                     shuffle_options, show_result: instant|after_review)
assessment_items    (assessment_id, question_id, points, position)
submissions         (id, assessment_id, student_id, started_at, submitted_at,
                     score, max_score, status: in_progress|submitted|graded)
answers             (submission_id, question_id, response jsonb, is_correct,
                     points_awarded, feedback, image_url)

class_sessions      (id, group_id, starts_at)                            -- المرحلة 2
attendance          (session_id, student_id, status, scanned_at, by_user) -- المرحلة 2
fee_payments        (id, group_id, student_id, period, amount, status, method) -- المرحلة 2

subscriptions       (id, owner_id, owner_kind: teacher|student, plan, status,
                     current_period_end, provider, provider_ref)
announcements       (id, group_id, author_id, body, created_at)
device_tokens       (user_id, token, platform)
```

### قواعد الأمان (Row Level Security), أمثلة
- المدرس يقرا ويكتب بس المجموعات اللي `teacher_id` بتاعها هو.
- الطالب يقرا بس الامتحانات اللي في مجموعة هو عضو فيها `active`.
- الطالب **ميقدرش يقرا** `correct_answer` غير بعد ما يسلم، والتصحيح يحصل على السيرفر بدالة (RPC) مش على الموبايل.
- ولي الأمر يقرا درجات الطالب بس لو `parent_links.status = verified`.

## 4. تدفق أساسي: الطالب يحل امتحان
1. الطالب يفتح الامتحان، فدالة `start_submission` تعمل submission وترجع الأسئلة **من غير الإجابات الصح** وبترتيب عشوائي.
2. الإجابات تتحفظ أول بأول، عشان لو النت قطع ميضيعش اللي حله.
3. يسلم، فدالة `submit_and_grade` تصحح الموضوعي وتحسب الدرجة.
4. Trigger يبعت إشعار للمدرس ولولي الأمر.

## 5. البيئات
- `dev`: مشروع Supabase مجاني للتجربة.
- `prod`: مشروع Supabase مدفوع وقت الإطلاق.
- المفاتيح بتتحط بـ `--dart-define` ومش بتتحفظ في الكود.

## 6. البناء والرفع
- Android: `flutter build appbundle` ← Google Play Console.
- iOS: `flutter build ipa` ← App Store Connect، ومن غير ماك عن طريق GitHub Actions بأجهزة macOS زي ما عملنا في تطبيق "ربح البيع".
