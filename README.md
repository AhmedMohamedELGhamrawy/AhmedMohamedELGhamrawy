# ربح البيع — نسخة الآيفون (iOS)

ده نفس تطبيق الأندرويد بالظبط (نفس الأسئلة والتصميم)، متحوّل لمشروع iOS جاهز للرفع على App Store.

- **Bundle ID:** `com.elghamrawy.myapp` (نفس الأندرويد)
- **الإصدار:** 3.1
- **الأجهزة:** آيفون فقط، والشاشة بالطول (Portrait)
- **مش محتاج جهاز Mac:** البناء والرفع بيحصلوا أوتوماتيك على أجهزة ماك تابعة لـ GitHub.

---

## الخطوة 1: الاشتراك في Apple Developer

1. ادخل على https://developer.apple.com/programs/enroll وسجّل بحساب Apple ID بتاعك.
2. اختار **Individual** (فرد) وادفع الـ 99 دولار.
3. استنى الموافقة، وغالبًا بتاخد من يوم لـ يومين.

## الخطوة 2: اعرف الـ Team ID بتاعك

ادخل على https://developer.apple.com/account وانزل لـ **Membership details**، وانسخ **Team ID** (عشر حروف وأرقام زي `AB12CD34EF`).

## الخطوة 3: سجّل الـ Bundle ID

1. ادخل على https://developer.apple.com/account/resources/identifiers/list
2. اضغط **+** واختار **App IDs** ثم **App**.
3. الـ Description اكتب فيه `Ribh Albay`، والـ Bundle ID اختار **Explicit** واكتب فيه `com.elghamrawy.myapp`.
4. علّم على **Push Notifications** (اختياري)، وبعدين اضغط **Continue** ثم **Register**.

## الخطوة 4: اعمل التطبيق في App Store Connect

1. ادخل على https://appstoreconnect.apple.com ثم **Apps** واضغط **+** واختار **New App**.
2. المنصة: **iOS**، والاسم: **ربح البيع** (لو الاسم محجوز جرّب "ربح البيع - أسئلة إسلامية").
3. اللغة الأساسية: **Arabic**.
4. الـ Bundle ID: اختار `com.elghamrawy.myapp`.
5. الـ SKU: أي حاجة، مثلًا `ribh-albay`.

## الخطوة 5: اعمل مفتاح API (عشان GitHub يرفع بدالك)

1. في App Store Connect ادخل على **Users and Access** ثم **Integrations** ثم **App Store Connect API**.
2. اضغط **Generate API Key** (أو **+**)، وخلي الاسم `GitHub` والصلاحية **App Manager**.
3. نزّل ملف المفتاح `AuthKey_XXXXXX.p8`. ⚠️ **بيتنزّل مرة واحدة بس، فاحفظه كويس.**
4. انسخ:
   - **Key ID** (جنب المفتاح)
   - **Issuer ID** (فوق الجدول)

## الخطوة 6: حط البيانات في GitHub Secrets

في صفحة الريبو على GitHub ادخل على **Settings** ثم **Secrets and variables** ثم **Actions** واضغط **New repository secret**، وضيف الأربعة دول:

| الاسم | القيمة |
|---|---|
| `APPLE_TEAM_ID` | الـ Team ID من الخطوة 2 |
| `ASC_KEY_ID` | الـ Key ID من الخطوة 5 |
| `ASC_ISSUER_ID` | الـ Issuer ID من الخطوة 5 |
| `ASC_KEY_P8` | افتح ملف `.p8` بـ Notepad وانسخ كل اللي فيه (بما فيه سطور BEGIN و END) |

> ⚠️ أوعى تحط ملف الـ `.p8` نفسه جوه الريبو أو تبعته لحد.

## الخطوة 7: ابني وارفع

1. في الريبو ادخل على تبويب **Actions** ثم **iOS Build**.
2. اضغط **Run workflow** وسيب **Upload to App Store Connect** متعلّم عليه، وبعدين اضغط **Run workflow**.
3. استنى حوالي 10–15 دقيقة لحد ما يبقى ✅ أخضر.
4. بعد ربع ساعة تقريبًا النسخة هتظهر في App Store Connect تحت تبويب **TestFlight**.

> كل مرة تضغط Run رقم الـ Build بيزيد لوحده، فمش محتاج تغيّر حاجة.

## الخطوة 8: جرّب على موبايلك (اختياري بس مهم)

نزّل تطبيق **TestFlight** من الآب ستور، وفي App Store Connect ادخل على **TestFlight** ثم **Internal Testing** وضيف نفسك. هتقدر تجرّب التطبيق على الآيفون قبل ما تبعته للمراجعة.

## الخطوة 9: املأ صفحة التطبيق وابعته للمراجعة

في App Store Connect، صفحة التطبيق، املأ:

- **الوصف والكلمات المفتاحية** (Description, Keywords). ممكن تاخد الوصف من جوجل بلاي.
- **صور الشاشة:** لازم مقاس **6.9 بوصة** (1320×2868) على الأقل، 3 صور أو أكتر.
- **Support URL** و **Privacy Policy URL:** لازم روابط شغالة. لو معندكش، اعمل صفحة على Google Sites تقول إن التطبيق مش بيجمع بيانات.
- **App Privacy:** اختار **Data Not Collected** (التطبيق بيحفظ النتائج على الموبايل بس).
- **Age Rating:** جاوب على الأسئلة، وكلها غالبًا "None".
- **Category:** Education أو Reference.
- **السعر:** Free.
- تحت **Build** اختار النسخة اللي اترفعت، وبعدين اضغط **Add for Review** ثم **Submit**.

المراجعة بتاخد عادةً من يوم لـ 3 أيام.

---

## ملاحظات فنية

- المشروع مبني بـ **Capacitor 8**، ودي نفس التقنية اللي مينوس عمل بيها نسخة الأندرويد.
- ملفات التطبيق موجودة في `www/`، ومتاخدة كما هي من ملف الـ AAB (إصدار 3.1، Build 25).
- شلت سكريبت الإحصائيات بتاع مينوس (manus-analytics) عشان تقدر تختار "Data Not Collected" في خانة الخصوصية بأمان.
- لو عدّلت التطبيق في مينوس، انسخ ملفات الويب الجديدة (`dist/public`) مكان `www/`، وبعدين شغّل Run workflow تاني.
- كل `push` على الريبو بيعمل بناء تجريبي (من غير توقيع) للتأكد إن المشروع سليم.
