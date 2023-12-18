close all
clear all
clc
%% raidþiø pavyzdþiø nuskaitymas ir poþymiø skaièiavimas
%% read the image with hand-written characters
pavadinimas = 'train_data.png';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 8);
%% Atpaþintuvo kûrimas
%% Development of character recognizer
% poþymiai ið celiø masyvo perkeliami á matricà
% take the features from cell-type variable and save into a matrix-type variable
P = cell2mat(pozymiai_tinklo_mokymui);
% sukuriama teisingø atsakymø matrica: 11 raidþiø, 8 eilutës mokymui
% create the matrices of correct answers for each line (number of matrices = number of symbol lines)
T = [eye(11), eye(11), eye(11), eye(11), eye(11), eye(11), eye(11), eye(11)];

% Sukuriamas naujas feedforward backpropagation tinklas
% Nustatomas paslėptųjų sluoksnių dydis (pvz., vienas sluoksnis su 12 neuronų)

maxRetrains = 100; % kad išvengtume begalinės kilpos nustatom kiek kartu meginsim skaičiuoti tikimybę
retrainCount = 0; % skaitliukas, kad būtu žinoma kiek kartų buvo skaičiuojama tikimybė

while retrainCount < maxRetrains % pradedama kilpa kuri užsibaigs jei bus pasiektas 100 pakartojimų
    while retrainCount < maxRetrains % pradedama kilpa kuri užsibaigs jei bus pasiektas 100 pakartojimų

        tinklas = feedforwardnet([20 20], 'trainlm');%scg lm
        
          % scg - gradianto sklidimo atgal
          % lm - Levenberg-Marquardt backpropagation
        
        % Nustatomas mokymo parametrai
        tinklas.trainParam.epochs = 1000;
        tinklas.trainParam.goal = 0.000000000000000000000000000000000000001;
        
        % Tinklo mokymas
        [tinklas, tr] = train(tinklas, P, T);
        
        %% Tinklo patikra | Test of the network (recognizer)
        % skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
        % estimate output of the network for unknown symbols (row, that were not used during training)
        P2 = P(:,12:22);
        Y2 = sim(tinklas, P2);
        % ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
        % find which neural network output gives maximum value
        [a2, b2] = max(Y2);
        %% Rezultato atvaizdavimas
        %% Visualize result
        % apskaièiuosime raidþiø skaièiø - poþymiø P2 stulpeliø skaièiø
        % calculate the total number of symbols in the row
        raidziu_sk = size(P2,2);
        % rezultatà saugosime kintamajame 'atsakymas'
        % we will save the result in variable 'atsakymas'
        atsakymas = [];
        for k = 1:raidziu_sk
            switch b2(k)
                case 1
                    % the symbol here should be the same as written first symbol in your image
                    atsakymas = [atsakymas, 'A'];
                case 2
                    atsakymas = [atsakymas, 'B'];
                case 3
                    atsakymas = [atsakymas, 'C'];
                case 4
                    atsakymas = [atsakymas, 'D'];
                case 5
                    atsakymas = [atsakymas, 'E'];
                case 6
                    atsakymas = [atsakymas, 'F'];
                case 7
                    atsakymas = [atsakymas, 'G'];
                case 8
                    atsakymas = [atsakymas, 'H'];
                case 9
                    atsakymas = [atsakymas, 'I'];
                case 10
                    atsakymas = [atsakymas, 'K'];
                case 11
                    atsakymas = [atsakymas, 'J'];
            end
        end
        % pateikime rezultatà komandiniame lange
        % show the result in command window
        disp(atsakymas)
        % % figure(7), text(0.1,0.5,atsakymas,'FontSize',38)
        %% þodþio "KADA" poþymiø iðskyrimas 
        %% Extract features of the test image
        pavadinimas = 'test_kada.png';
        pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);
        
        %% Raidþiø atpaþinimas
        %% Perform letter/symbol recognition
        % poþymiai ið celiø masyvo perkeliami á matricà
        % features from cell-variable are stored to matrix-variable
        P2 = cell2mat(pozymiai_patikrai);
        % skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
        % estimating neuran network output for newly estimated features
        Y2 = sim(tinklas, P2);
        % ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
        % searching which output gives maximum value
        [a2, b2] = max(Y2);
        %% Rezultato atvaizdavimas | Visualization of result
        % apskaièiuosime raidþiø skaièiø - poþymiø P2 stulpeliø skaièiø
        % calculating number of symbols - number of columns
        raidziu_sk = size(P2,2);
        % rezultatà saugosime kintamajame 'atsakymas'
        atsakymas = [];
        for k = 1:raidziu_sk
            switch b2(k)
                case 1
                    atsakymas = [atsakymas, 'A'];
                case 2
                    atsakymas = [atsakymas, 'B'];
                case 3
                    atsakymas = [atsakymas, 'C'];
                case 4
                    atsakymas = [atsakymas, 'D'];
                case 5
                    atsakymas = [atsakymas, 'E'];
                case 6
                    atsakymas = [atsakymas, 'F'];
                case 7
                    atsakymas = [atsakymas, 'G'];
                case 8
                    atsakymas = [atsakymas, 'H'];
                case 9
                    atsakymas = [atsakymas, 'I'];
                case 10
                    atsakymas = [atsakymas, 'K'];
                case 11
                    atsakymas = [atsakymas, 'J'];
            end
        end
        % pateikime rezultatà komandiniame lange
        % disp(atsakymas)
        figure(8), text(0.1,0.5,atsakymas,'FontSize',38), axis off
    
    
        atss ='KADA';
    
    
        if atsakymas == atss
            disp(['Atsakymas ' num2str(atsakymas)]);
            disp('Pirmas žodis buvo atspėtas, tikrinam antrą žodį :)');
            break;
        else
            retrainCount = retrainCount + 1; % skaitliuko skai2iavimas d4l kilpos susidaryo
            disp(['Atsakymas ' num2str(atsakymas)]);
            disp('Pirmas žodis buvo neatspėtas, kartojam mokymą');            
            disp(['Naujas mokymosi bandymas ' num2str(retrainCount)]);
            clear atsakymas
            close all
        end
    end

    %% þodþio "FIKCIJA" poþymiø iðskyrimas 
    %% extract features for next/another test image
    pavadinimas = 'test_fikcija.png';
    pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);
    
    %% Raidþiø atpaþinimas
    % poþymiai ið celiø masyvo perkeliami á matricà
    P2 = cell2mat(pozymiai_patikrai);
    % skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
    Y2 = sim(tinklas, P2);
    % ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
    [a2, b2] = max(Y2);
    %% Rezultato atvaizdavimas
    % apskaièiuosime raidþiø skaièiø - poþymiø P2 stulpeliø skaièiø
    raidziu_sk = size(P2,2);
    % rezultatà saugosime kintamajame 'atsakymas'
    atsakymas = [];
    for k = 1:raidziu_sk
        switch b2(k)
            case 1
                atsakymas = [atsakymas, 'A'];
            case 2
                atsakymas = [atsakymas, 'B'];
            case 3
                atsakymas = [atsakymas, 'C'];
            case 4
                atsakymas = [atsakymas, 'D'];
            case 5
                atsakymas = [atsakymas, 'E'];
            case 6
                atsakymas = [atsakymas, 'F'];
            case 7
                atsakymas = [atsakymas, 'G'];
            case 8
                atsakymas = [atsakymas, 'H'];
            case 9
                atsakymas = [atsakymas, 'I'];
            case 10
                atsakymas = [atsakymas, 'K'];
            case 11
                atsakymas = [atsakymas, 'J'];
        end
    end
    % pateikime rezultatà komandiniame lange
    % disp(atsakymas)
    figure(9), text(0.1,0.5,atsakymas,'FontSize',38), axis off

    
    ats ='FIKCIJA';


    if atsakymas == ats
        disp(['Atsakymas ' num2str(atsakymas)]);        
        disp('Antras žodis buvo atspėtas :)');
        break;
    else
        retrainCount = retrainCount + 1; % skaitliuko skai2iavimas d4l kilpos susidaryo
        disp(['Atsakymas ' num2str(atsakymas)]);
        disp('Antras žodis buvo neatspėtas, kartojam mokymą');                    
        disp(['Naujas mokymosi bandymas ' num2str(retrainCount)]);
        clear atsakymas
        close all
    end
    
end

if retrainCount == maxRetrains
    disp('pasiektas 100 bandymų kiekis nepasiekus norimo rezultao');
end


    


