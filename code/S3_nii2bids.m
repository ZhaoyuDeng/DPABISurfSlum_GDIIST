% Convert structure to BIDS structure
% Zhaoyu Deng, Nov. 19 2025

clear; clc;

InDir = '....../3_NIfTI';
OutDir = '....../4_Analysis2';
BIDSDir = [OutDir,filesep,'BIDS'];
mkdir(OutDir);
mkdir(BIDSDir);

subs = {dir(InDir).name}';
subs = subs(3:end);
subjects = cell(length(subs),1);

for k=1:length(subs)
    % number = num2str(k,'%03d');
    subid = ['sub-1',replace(replace(subs{k},'_',''),'-','')];
    % subid = ['sub-',number];
    subjects{k} = subid;
    disp(subid);

    subdir = [BIDSDir,filesep,subid];
    anatdir = [subdir,filesep,'anat'];
    funcdir = [subdir,filesep,'func'];
    mkdir(subdir);
    mkdir(anatdir);
    mkdir(funcdir);
    
    allfiles = {dir([InDir,filesep,subs{k}]).name}';
    allfiles = allfiles(3:end);

    for l=1:length(allfiles)
        elem = split(allfiles{l},'_');
        [filepath,name,ext] = fileparts([subdir,filesep,allfiles{l}]);

        if strcmp(elem{1},"T1")
            newname = [subid,'_T1w',ext];
            copyfile([InDir,filesep,subs{k},filesep,allfiles{l}],[anatdir,filesep,newname]);
            disp(newname);
        elseif strcmp(elem{1},"BOLD")
            newname = [subid,'_task-rest_bold',ext];
            copyfile([InDir,filesep,subs{k},filesep,allfiles{l}],[funcdir,filesep,newname]);
            if strcmp(ext,'.json')
                json = readstruct([funcdir,filesep,newname]);
                json.TaskName = "rest";
                writestruct(json,[funcdir,filesep,newname])
            end
            disp(newname);
        end
        
    end
end

for k=1:length(subs)
    % number = num2str(k,'%03d');
    subid = ['sub-2',replace(replace(subs{k},'_',''),'-','')];
    % subid = ['sub-',number];
    subjects{k+length(subs)} = subid;
    disp(subid);

    subdir = [BIDSDir,filesep,subid];
    anatdir = [subdir,filesep,'anat'];
    funcdir = [subdir,filesep,'func'];
    mkdir(subdir);
    mkdir(anatdir);
    mkdir(funcdir);
    
    allfiles = {dir([InDir,filesep,subs{k}]).name}';
    allfiles = allfiles(3:end);

    for l=1:length(allfiles)
        elem = split(allfiles{l},'_');
        [filepath,name,ext] = fileparts([subdir,filesep,allfiles{l}]);

        if strcmp(elem{1},"T1")
            newname = [subid,'_T1w',ext];
            copyfile([InDir,filesep,subs{k},filesep,allfiles{l}],[anatdir,filesep,newname]);
            disp(newname);
        elseif strcmp(elem{1},"BOLD2")
            newname = [subid,'_task-rest_bold',ext];
            copyfile([InDir,filesep,subs{k},filesep,allfiles{l}],[funcdir,filesep,newname]);
            if strcmp(ext,'.json')
                json = readstruct([funcdir,filesep,newname]);
                json.TaskName = "rest";
                writestruct(json,[funcdir,filesep,newname])
            end
            disp(newname);
        end
        
    end
end

writecell(subjects,[OutDir,filesep,'subjects.txt'])

