/****************************************************************************
** Meta object code from reading C++ file 'backend.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../PostingTo/c++/backend.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'backend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Backend_t {
    QByteArrayData data[23];
    char stringdata0[187];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Backend_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Backend_t qt_meta_stringdata_Backend = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Backend"
QT_MOC_LITERAL(1, 8, 6), // "newMsg"
QT_MOC_LITERAL(2, 15, 0), // ""
QT_MOC_LITERAL(3, 16, 3), // "msg"
QT_MOC_LITERAL(4, 20, 7), // "welcome"
QT_MOC_LITERAL(5, 28, 6), // "loginS"
QT_MOC_LITERAL(6, 35, 6), // "loginF"
QT_MOC_LITERAL(7, 42, 5), // "signS"
QT_MOC_LITERAL(8, 48, 5), // "signF"
QT_MOC_LITERAL(9, 54, 10), // "getChatMsg"
QT_MOC_LITERAL(10, 65, 2), // "id"
QT_MOC_LITERAL(11, 68, 4), // "name"
QT_MOC_LITERAL(12, 73, 4), // "room"
QT_MOC_LITERAL(13, 78, 9), // "clearRoom"
QT_MOC_LITERAL(14, 88, 10), // "getNewRoom"
QT_MOC_LITERAL(15, 99, 13), // "getRoomFinish"
QT_MOC_LITERAL(16, 113, 19), // "getShowYearChampion"
QT_MOC_LITERAL(17, 133, 4), // "time"
QT_MOC_LITERAL(18, 138, 4), // "sygj"
QT_MOC_LITERAL(19, 143, 9), // "memberAdd"
QT_MOC_LITERAL(20, 153, 6), // "roomid"
QT_MOC_LITERAL(21, 160, 8), // "read_msg"
QT_MOC_LITERAL(22, 169, 17) // "send_message_test"

    },
    "Backend\0newMsg\0\0msg\0welcome\0loginS\0"
    "loginF\0signS\0signF\0getChatMsg\0id\0name\0"
    "room\0clearRoom\0getNewRoom\0getRoomFinish\0"
    "getShowYearChampion\0time\0sygj\0memberAdd\0"
    "roomid\0read_msg\0send_message_test"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Backend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      12,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   84,    2, 0x06 /* Public */,
       4,    0,   87,    2, 0x06 /* Public */,
       5,    0,   88,    2, 0x06 /* Public */,
       6,    0,   89,    2, 0x06 /* Public */,
       7,    0,   90,    2, 0x06 /* Public */,
       8,    0,   91,    2, 0x06 /* Public */,
       9,    4,   92,    2, 0x06 /* Public */,
      13,    0,  101,    2, 0x06 /* Public */,
      14,    1,  102,    2, 0x06 /* Public */,
      15,    0,  105,    2, 0x06 /* Public */,
      16,    4,  106,    2, 0x06 /* Public */,
      19,    1,  115,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      21,    0,  118,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      22,    1,  119,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QVariant,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QVariant, QMetaType::QVariant, QMetaType::QVariant, QMetaType::QVariant,   10,    3,   11,   12,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QVariant,   10,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QVariant, QMetaType::QVariant, QMetaType::QVariant, QMetaType::QVariant,   10,   11,   17,   18,
    QMetaType::Void, QMetaType::QVariant,   20,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QVariant,    3,

       0        // eod
};

void Backend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Backend *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->newMsg((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 1: _t->welcome(); break;
        case 2: _t->loginS(); break;
        case 3: _t->loginF(); break;
        case 4: _t->signS(); break;
        case 5: _t->signF(); break;
        case 6: _t->getChatMsg((*reinterpret_cast< QVariant(*)>(_a[1])),(*reinterpret_cast< QVariant(*)>(_a[2])),(*reinterpret_cast< QVariant(*)>(_a[3])),(*reinterpret_cast< QVariant(*)>(_a[4]))); break;
        case 7: _t->clearRoom(); break;
        case 8: _t->getNewRoom((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 9: _t->getRoomFinish(); break;
        case 10: _t->getShowYearChampion((*reinterpret_cast< QVariant(*)>(_a[1])),(*reinterpret_cast< QVariant(*)>(_a[2])),(*reinterpret_cast< QVariant(*)>(_a[3])),(*reinterpret_cast< QVariant(*)>(_a[4]))); break;
        case 11: _t->memberAdd((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 12: _t->read_msg(); break;
        case 13: _t->send_message_test((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Backend::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::newMsg)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::welcome)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::loginS)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::loginF)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signS)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signF)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QVariant , QVariant , QVariant , QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::getChatMsg)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::clearRoom)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::getNewRoom)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::getRoomFinish)) {
                *result = 9;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QVariant , QVariant , QVariant , QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::getShowYearChampion)) {
                *result = 10;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QVariant );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::memberAdd)) {
                *result = 11;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Backend::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_Backend.data,
    qt_meta_data_Backend,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Backend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Backend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Backend.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Backend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
    return _id;
}

// SIGNAL 0
void Backend::newMsg(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Backend::welcome()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Backend::loginS()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Backend::loginF()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Backend::signS()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void Backend::signF()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void Backend::getChatMsg(QVariant _t1, QVariant _t2, QVariant _t3, QVariant _t4)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void Backend::clearRoom()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void Backend::getNewRoom(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void Backend::getRoomFinish()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void Backend::getShowYearChampion(QVariant _t1, QVariant _t2, QVariant _t3, QVariant _t4)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void Backend::memberAdd(QVariant _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
