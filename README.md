# Mailmerge

A bare-bones mailmerge script.

## How it works

The mailmerge combines a CSV file of email addresses and associated data, with a TEXT file containing
the subject and body of an email.

It uses the headers of the CSV file to replace placeholders in the email template.

Take a look at test.csv (the data) and test.txt (the email template) for an example.

**Required fields**

The CSV file must have a header named `email`, which contains the email addresses used to dispatch
the emails.

## Setup

Install the dependencies using bundler.

```
bundle install
```

Create a .env file, and define the SMTP settings:

```
cp env.example .env
# edit .env
```

That can be whatever SMTP settings you have. Sendgrid, Mailgun, Gmail, etc.

If you want to send email from your Gmail account, you can set up an application-specific password, in
https://security.google.com/settings/security/apppasswords

```
SMTP_LOGIN=<your gmail address>
SMTP_PASSWORD=<your app-specific password>
SMTP_PORT=587
SMTP_SERVER=smtp.gmail.net
```

## Sending Emails

Send emails with the following command:

```
CSV=foo.csv TEMPLATE=bar.txt ./mailmerge
```

If you don't pass the CSV and TEMPLATE arguments, then the script will use the defaults:

```
CSV=test.csv
TEMPLATE=test.txt
```

Set `PREVIEW=1` to view a preview of the emails without actually sending them.

```
PREVIEW=1 CSV=foo.csv TEMPLATE=bar.txt ./mailmerge
```

### Email Template

The first line of the template file is used for the subject line.

The rest of the file is used as the body of the email.

Each header can be referenced in the email template using the header name,
enclosed in double curly-braces (e.g. `{{username}}`).

See `test.txt` for an example.
