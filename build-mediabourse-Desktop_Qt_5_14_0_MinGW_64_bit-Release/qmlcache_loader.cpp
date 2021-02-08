#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>

static const unsigned char qt_resource_tree[] = {
0,
0,0,0,0,2,0,0,0,2,0,0,0,1,0,0,0,
8,0,0,0,0,0,1,0,0,0,0,0,0,0,30,0,
2,0,0,0,2,0,0,0,3,0,0,0,50,0,2,0,
0,0,1,0,0,0,12,0,0,0,84,0,2,0,0,0,
3,0,0,0,5,0,0,0,126,0,2,0,0,0,4,0,
0,0,8,0,0,1,20,0,0,0,0,0,1,0,0,0,
0,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,
0,0,142,0,0,0,0,0,1,0,0,0,0,0,0,0,
210,0,0,0,0,0,1,0,0,0,0,0,0,0,240,0,
0,0,0,0,1,0,0,0,0,0,0,0,172,0,0,0,
0,0,1,0,0,0,0,0,0,0,64,0,0,0,0,0,
1,0,0,0,0};
static const unsigned char qt_resource_names[] = {
0,
1,0,0,0,47,0,47,0,8,8,1,90,92,0,109,0,
97,0,105,0,110,0,46,0,113,0,109,0,108,0,7,10,
101,172,212,0,67,0,111,0,110,0,116,0,101,0,110,0,
116,0,4,0,6,214,84,0,102,0,111,0,110,0,116,0,
7,15,166,21,147,0,73,0,99,0,111,0,110,0,46,0,
106,0,115,0,5,0,106,90,195,0,99,0,111,0,100,0,
101,0,115,0,10,15,207,181,60,0,80,0,108,0,97,0,
121,0,101,0,114,0,46,0,113,0,109,0,108,0,5,0,
92,176,51,0,85,0,116,0,105,0,108,0,115,0,12,9,
86,159,124,0,68,0,114,0,111,0,112,0,84,0,105,0,
108,0,101,0,46,0,113,0,109,0,108,0,16,13,106,192,
92,0,81,0,117,0,101,0,115,0,116,0,105,0,111,0,
110,0,84,0,105,0,108,0,101,0,46,0,113,0,109,0,
108,0,12,9,88,177,124,0,68,0,114,0,97,0,103,0,
84,0,105,0,108,0,101,0,46,0,113,0,109,0,108,0,
15,13,53,171,60,0,83,0,101,0,97,0,114,0,99,0,
104,0,70,0,105,0,101,0,108,0,100,0,46,0,113,0,
109,0,108,0,13,3,208,177,156,0,80,0,108,0,97,0,
121,0,101,0,114,0,87,0,105,0,110,0,46,0,113,0,
109,0,108};
static const unsigned char qt_resource_empty_payout[] = { 0, 0, 0, 0, 0 };
QT_BEGIN_NAMESPACE
extern Q_CORE_EXPORT bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
QT_END_NAMESPACE
namespace QmlCacheGeneratedCode {
namespace _0x5f_Content_codes_PlayerWin_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f_Content_codes_Utils_SearchField_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f_Content_font_Icon_js { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f_Content_codes_Player_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__main_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f_Content_codes_Utils_DragTile_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f_Content_codes_Utils_QuestionTile_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f_Content_codes_Utils_DropTile_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/codes/PlayerWin.qml"), &QmlCacheGeneratedCode::_0x5f_Content_codes_PlayerWin_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/codes/Utils/SearchField.qml"), &QmlCacheGeneratedCode::_0x5f_Content_codes_Utils_SearchField_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/font/Icon.js"), &QmlCacheGeneratedCode::_0x5f_Content_font_Icon_js::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/codes/Player.qml"), &QmlCacheGeneratedCode::_0x5f_Content_codes_Player_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/main.qml"), &QmlCacheGeneratedCode::_0x5f__main_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/codes/Utils/DragTile.qml"), &QmlCacheGeneratedCode::_0x5f_Content_codes_Utils_DragTile_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/codes/Utils/QuestionTile.qml"), &QmlCacheGeneratedCode::_0x5f_Content_codes_Utils_QuestionTile_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Content/codes/Utils/DropTile.qml"), &QmlCacheGeneratedCode::_0x5f_Content_codes_Utils_DropTile_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.version = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
QT_PREPEND_NAMESPACE(qRegisterResourceData)(/*version*/0x01, qt_resource_tree, qt_resource_names, qt_resource_empty_payout);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qml)() {
    ::unitRegistry();
    Q_INIT_RESOURCE(qml_qmlcache);
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qml))
int QT_MANGLE_NAMESPACE(qCleanupResources_qml)() {
    Q_CLEANUP_RESOURCE(qml_qmlcache);
    return 1;
}
