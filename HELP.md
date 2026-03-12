"string" <> "other string"
%{key: "value"}
%{state | key: "value"}

        ^- оставляет state и изменяет только следующее после | поле

${"key" => "value"}

        ^- для строковых ключей

