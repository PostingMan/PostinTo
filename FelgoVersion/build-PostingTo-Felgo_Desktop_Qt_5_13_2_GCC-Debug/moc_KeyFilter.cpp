/****************************************************************************
** Meta object code from reading C++ file 'KeyFilter.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../PostingTo/c++/KeyFilter.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'KeyFilter.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_KeyFilter_t {
    QByteArrayData data[4];
    char stringdata0[40];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_KeyFilter_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_KeyFilter_t qt_meta_stringdata_KeyFilter = {
    {
QT_MOC_LITERAL(0, 0, 9), // "KeyFilter"
QT_MOC_LITERAL(1, 10, 16), // "sig_KeyBackPress"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 11) // "sig_AppExit"

    },
    "KeyFilter\0sig_KeyBackPress\0\0sig_AppExit"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_KeyFilter[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   24,    2, 0x06 /* Public */,
       3,    0,   25,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void KeyFilter::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<KeyFilter *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->sig_KeyBackPress(); break;
        case 1: _t->sig_AppExit(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (KeyFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&KeyFilter::sig_KeyBackPress)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (KeyFilter::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&KeyFilter::sig_AppExit)) {
                *result = 1;
                return;
            }
        }
    }
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject KeyFilter::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_KeyFilter.data,
    qt_meta_data_KeyFilter,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *KeyFilter::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *KeyFilter::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_KeyFilter.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int KeyFilter::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void KeyFilter::sig_KeyBackPress()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void KeyFilter::sig_AppExit()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
