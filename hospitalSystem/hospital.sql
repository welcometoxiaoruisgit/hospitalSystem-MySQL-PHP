create table hospital
(
    id         int         not null comment 'id of the hospital'
        primary key,
    name       varchar(20) not null comment 'The name of the hospital',
    nurseNum   int         not null comment 'how many nurses in this hospital',
    doctorNum  int         not null comment 'how many doctors',
    patientNum int         not null comment 'how many patients',
    constraint name
        unique (name),
    check ((`nurseNum` >= 0) and (`nurseNum` <= 5)),
    check ((`doctorNum` >= 0) and (`doctorNum` <= 3)),
    check ((`patientNum` >= 0) and (`patientNum` <= 10))
)
    comment 'Hospital information';

create table doctor
(
    id       int auto_increment comment 'primary key'
        primary key,
    docID    int         not null comment 'the id of the doctor',
    docName  varchar(20) not null comment 'the name of the doctor',
    docAge   int         not null comment 'the age of the doctor',
    hospName varchar(20) not null comment 'the doctor is in which hospital',
    constraint docID
        unique (docID),
    constraint docLoca_fk_hosp
        foreign key (hospName) references hospital (name)
            on update cascade on delete cascade,
    check (`docAge` > 0)
)
    comment 'the information of the doctor';

create index doc_ID_Age_Loca_respPatID
    on doctor (id, docID, docName, docAge, hospName);

create index index_doc_name_hosp
    on doctor (docName, hospName);

create table hospdoc
(
    hospID int not null,
    docID  int not null,
    primary key (hospID, docID),
    constraint hospDoc_docID_fk
        foreign key (docID) references doctor (docID)
            on update cascade on delete cascade,
    constraint hospDoc_hospID_fk
        foreign key (hospID) references hospital (id)
            on update cascade on delete cascade
);

create index hosp_union_Info
    on hospital (id, name, nurseNum, doctorNum, patientNum);

create table hosplocations
(
    id       int         not null
        primary key,
    location varchar(20) not null,
    constraint location
        unique (location),
    constraint hosp_location
        foreign key (id) references hospital (id)
            on update cascade on delete cascade
);

create table nurse
(
    id       int auto_increment
        primary key,
    nurID    int         not null comment 'the id of the nurse',
    nurName  varchar(20) not null comment 'the name of the nurse',
    nurAge   int         not null comment 'the age of the nurse',
    hospName varchar(20) not null comment 'the nurse is in which location',
    constraint nurID
        unique (nurID),
    constraint nurLoca_fk_hosp
        foreign key (hospName) references hospital (name)
            on update cascade on delete cascade,
    check (`nurAge` > 0)
)
    comment 'the information of the nurse';

create table hospnur
(
    hospID int not null,
    nurID  int not null,
    primary key (hospID, nurID),
    constraint hospNur_hospID_fk
        foreign key (hospID) references hospital (id)
            on update cascade on delete cascade,
    constraint hospNur_nurID_fk
        foreign key (nurID) references nurse (nurID)
            on update cascade on delete cascade
);

create index index_nur_name_hosp
    on nurse (nurName, hospName);

create index nur_ID_Age_dept_Loca
    on nurse (id, nurID, nurName, nurAge, hospName);

create table patient
(
    id            int auto_increment comment 'primary key'
        primary key,
    patID         int         not null comment 'The id of the patient',
    patName       varchar(15) not null comment 'The name of the patient',
    patGender     varchar(10) null comment 'The gender of the patient',
    patAge        int         not null comment 'The age of the patient',
    patPhoneNum   varchar(15) null comment 'The phone number of the patient',
    disease       varchar(30) not null comment 'The disease of the patient',
    treatment     varchar(30) not null comment 'The treatment which is going on',
    days          int         not null comment 'the number of days the patient are admitted',
    primaryDocID  int         not null comment 'The id of the primary doctor of the patient',
    patLocation   varchar(20) not null comment 'The patient live in which location',
    admitLocation varchar(20) not null comment 'The location where the patient is admitted',
    constraint patID
        unique (patID),
    constraint patPhoneNum
        unique (patPhoneNum),
    check (`days` >= 0)
)
    comment 'The information of the patient';

create table admission
(
    id          int auto_increment
        primary key,
    attendDocID int         not null,
    nurID       int         not null,
    patID       int         not null,
    dest        varchar(20) not null,
    constraint admission_dest
        foreign key (dest) references hospital (name)
            on update cascade on delete cascade,
    constraint admission_docID
        foreign key (attendDocID) references doctor (docID)
            on update cascade on delete cascade,
    constraint admission_nurID
        foreign key (nurID) references nurse (nurID)
            on update cascade on delete cascade,
    constraint admission_patID
        foreign key (patID) references patient (patID)
            on update cascade on delete cascade
)
    comment 'the admission of the patient';

create index relocate_union
    on admission (id, attendDocID, nurID, patID, dest);

create table nurtakecarepat
(
    id    int auto_increment
        primary key,
    nurID int not null,
    patID int not null,
    constraint patID
        unique (patID),
    constraint nurTakeCarePat_nurID
        foreign key (nurID) references nurse (nurID)
            on update cascade on delete cascade,
    constraint nurTakeCarePat_patID
        foreign key (patID) references patient (patID)
            on update cascade on delete cascade
)
    comment 'the info of nurse taking care of patients';

create index takeCare_nurID_patID
    on nurtakecarepat (id, nurID, patID);

create index idx_pat_name_phone
    on patient (patName, patPhoneNum);

create index union_patientInfo
    on patient (id, patID, patName, patGender, patAge, patPhoneNum, disease, treatment, days, primaryDocID, patLocation,
                admitLocation);

create table pharmacy
(
    id   int         not null comment 'primary key and the id of the pharmacy'
        primary key,
    name varchar(20) not null comment 'The name of the pharmacy',
    constraint name
        unique (name)
)
    comment 'Pharmacy Information';

create table drugorder
(
    id         int auto_increment comment 'primary key'
        primary key,
    hospName   varchar(20) not null comment 'which hospital pays the bill?',
    pharName   varchar(20) not null comment 'which pharmacy sends the drug?',
    drugName   varchar(20) not null comment 'the name of the drug',
    billAmount double      not null comment 'how much is the drug?',
    constraint drugOrder_fk_hospName
        foreign key (hospName) references hospital (name)
            on update cascade on delete cascade,
    constraint drugOrder_fk_pharName
        foreign key (pharName) references pharmacy (name)
            on update cascade on delete cascade,
    check (`billAmount` >= 0)
)
    comment 'The information of the drug order';

create index drugOrder_union_Info
    on drugorder (id, hospName, pharName, drugName, billAmount);

create index index_drugOrder_hosp_phar_drug
    on drugorder (hospName, pharName, drugName);

create table hospphar
(
    hospID int not null,
    pharID int not null,
    primary key (hospID, pharID),
    constraint hospPhar_hospID_fk
        foreign key (hospID) references hospital (id)
            on update cascade on delete cascade,
    constraint hospPhar_pharID_fk
        foreign key (pharID) references pharmacy (id)
            on update cascade on delete cascade
);

create table pharlocations
(
    id       int         not null
        primary key,
    location varchar(20) not null,
    constraint location
        unique (location),
    constraint phar_location
        foreign key (id) references pharmacy (id)
            on update cascade on delete cascade
);

create index pharmacy_id_name
    on pharmacy (id, name);

create table treatment
(
    id        int auto_increment
        primary key,
    patientID int         not null,
    doctorID  int         not null,
    disease   varchar(20) not null,
    constraint doctorID_fk
        foreign key (doctorID) references doctor (docID)
            on update cascade on delete cascade,
    constraint patientID_fk
        foreign key (patientID) references patient (patID)
            on update cascade on delete cascade
)
    comment 'Connection of the table patient and doctor';

create index connPD_patID_docID
    on treatment (id, patientID, doctorID, disease);

create definer = root@localhost view doctor_hospital_info as
select `doc`.`docID` AS `docID`, `doc`.`docName` AS `docName`, `doc`.`docAge` AS `docAge`, `hos`.`name` AS `hospName`
from (`hospitals`.`doctor` `doc`
         join `hospitals`.`hospital` `hos` on ((`doc`.`hospName` = `hos`.`name`)));

-- comment on column doctor_hospital_info.docID not supported: the id of the doctor

-- comment on column doctor_hospital_info.docName not supported: the name of the doctor

-- comment on column doctor_hospital_info.docAge not supported: the age of the doctor

-- comment on column doctor_hospital_info.hospName not supported: The name of the hospital

create definer = root@localhost view nurhosp_info as
select `nur`.`nurID` AS `nurID`, `nur`.`nurName` AS `nurName`, `nur`.`nurAge` AS `nurAge`, `hos`.`name` AS `hospName`
from (`hospitals`.`nurse` `nur`
         join `hospitals`.`hospital` `hos` on ((`nur`.`hospName` = `hos`.`name`)));

-- comment on column nurhosp_info.nurID not supported: the id of the nurse

-- comment on column nurhosp_info.nurName not supported: the name of the nurse

-- comment on column nurhosp_info.nurAge not supported: the age of the nurse

-- comment on column nurhosp_info.hospName not supported: The name of the hospital

create
    definer = root@localhost procedure calculatePatientBill(IN patName varchar(20))
begin
    select p.patName, p.days, o.billAmount, (o.billAmount / 100) * p.days as patientBill from patient p
             join drugOrder o on p.admitLocation = o.hospName
    where p.patName = patName;
end;


