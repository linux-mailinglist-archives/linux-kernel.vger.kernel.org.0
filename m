Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041AB31469
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEaSHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 14:07:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41602 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfEaSHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:07:50 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so8929205ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnwV+x6Nync2SRD/ie0xkgC2GLxe++H0mOQiquHxJOU=;
        b=UAsD6dArxk8+jnZHL6MTybZ8RIy1lutwvxg5PjnzMyKRXHSxdiKA40ynFIwdN5oZqX
         Abn32C5gWsbZ5d1kZUReJx3bQtW70UHIzsrSkl0XxQIKSBEcF/zchzeoz6hRZVQqP4Sa
         4/Z58LLmxEAGZOYrbffcL4N/Koj4vlUhpC9FWv//IdRbPlc/FxVqfedAq5ylIjcQlm7L
         Apfw8PtY39x3l5ZvSVwdemwg9w2xtjdVyiQ4KPUgJLBggraIw4p5VB63v+4ybUe6jr1c
         4bdL6eBuqk7Hpq7QqUyQxod+JJ+CaE9+sD5bJT5XAjt99W6HE535VnkbC1WEd0P9lDRI
         2EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnwV+x6Nync2SRD/ie0xkgC2GLxe++H0mOQiquHxJOU=;
        b=Y02TBE9BXFsoXrHdiu1kfXkE5idKVgI7ess3u4JVl1g4rdjKyfxqeac6juyRQyUZRx
         i8c3YEoZHO0LGK2UcdjyiQ3IxH8moM5s10K4fvEFwHfzRZmyqdeidiMyW6nIBx/iOmFj
         I2d/l0ZF7+W8j6wCWeU1OMZVAkEnLQzlrmI9Wz4TDkXbVFV8TnWPyZ3bM2un/krCueUF
         UN3Eyt1ONH4WVQZzp7xgnlQFzNSyz10TDKeVcyhI6RAI49B4xJUoE3YxoxRchmjJvGr5
         ZNmo3SFZYD/rslDThbZ6dWaBRbJXqhN/NjOIFaufYLY14PTugwZ2g/qlxz2S3M7CoCcF
         pWyg==
X-Gm-Message-State: APjAAAVBlyOQzEcjUSkiIJg9dWBAtHr7nx+m4QCrlJ4QWjEwFuMpg2t5
        ng2EYJwsYwRAj/gMvca7kClEdlWtWaUm9O9+TaRJfg==
X-Google-Smtp-Source: APXvYqxzg9XmiS0iSaI9StJim8e+eA3NblMlnd5i1k3SQW26ShdLMEtQlC9w7vyQMOL73cYu5BbJX9Xxoc85HBnJc58=
X-Received: by 2002:a6b:6b14:: with SMTP id g20mr7504962ioc.28.1559326068582;
 Fri, 31 May 2019 11:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205501.177637-1-matthewgarrett@google.com>
In-Reply-To: <20190520205501.177637-1-matthewgarrett@google.com>
From:   Joe Richey <joerichey@google.com>
Date:   Fri, 31 May 2019 11:07:37 -0700
Message-ID: <CAKpBdu1_U37u88rJQUJoh5bJ4pA6Qhek0jR4p8sV3dsz49+rJw@mail.gmail.com>
Subject: Re: [PATCH V7 0/4] Add support for crypto agile logs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        bsz@semihalf.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000072b6ca058a32e4d1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000072b6ca058a32e4d1
Content-Type: text/plain; charset="UTF-8"

On Mon, May 20, 2019 at 1:56 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Identical to previous version except without the KSAN workaround - Ard
> has a better solution for that.

I just tested this on x86_64 with the systemd-boot (previously gummiboot)
bootloader. For context, this bootloader is essentially just an EFI
chainloader. This bootloader measures the kernel cmdline into PCR 8.
However, it calls GetEventLog before calling HashLogExtendEvent, intending
to have the log entry written to the "EFI TCG 2.0 final events table". See:
    https://github.com/systemd/systemd/blob/75e40119a471454516ad0acc96f6f4094e7fb652/src/boot/efi/measure.c#L212-L227

With the current patchset, this log entry appears _twice_ in the sysfs file.
This is caused by the fact that the sysfs event log unconditionally appends
the entire final event log to the output of GetEventLog. However, the correct
behavior would be to append only the _new_ entries that appear in the final
event log to the output of GetEventLog.

This could be done by first calculating the length of the final events log
table, then recalculating the length of the final events log after the
kernel calls ExitBootServices. This would let us know for sure that we are
only appending new log entries.

--00000000000072b6ca058a32e4d1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFG6/jgVXjk39iBARYUuHmZCsTrTrMB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBtJ4NaR/zX
2J1ZDXrnIxYq0ncG1ChsKj1V6wae7E6B4hbWl0aBAcmKc+yuwrQpcaBsD0UnW5r6OBTRVigQrCe9
wuPrZSf0m+W2YtEaIalAY5z4lRk8Ejs9x7ao9IQefPMnlBAu4J3P2yPr2Z/H6kR7IAeoqRh74hRt
R0A3/jv+yqtVggpgW+GcSVII3+i6d1UWyZ36pyz/XDPj9U9sxyv0SP/nmVQ/fa84EU3K2waJe3JK
8Ouzzz+TKaX8Z+L0b3BirVkYIWbNig6VTzh75FQwVSOqRSJeSNypbshDB2Hui+ptRyhQxRDKfdWX
ravwoP1khGyAfyNl91xqxNPlfqmWMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
XsN7dVzFxfwQ99yiMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCK3WksVphcsxYy
ICZ8bkS+gQtYicNl+9RhJ/vWWGhdODAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xOTA1MzExODA3NDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQK/SYME1B9CnpYkEFXqlP7FXuIkuP5+3
6tfSqD1PC9UjPBAu4iye9MEdla9XFd5JLLKuVbCdyjwvPKAkVzJOQxatQykQ+eALmhrTlslciTD8
/USZ97O+RScUo5cajIyur+ochBCqsBN8H7WpxRCTlTJQjWY4GuXVMi8vknJ5j5wRalILSdg7XfWm
BFGo+HNLJrJ+CsnQQfMnAY/YjkvQuGdwP+oNJqAW4WMm4okBvQ4L+CgU8NObW6VWUWEwCiHTX42i
eWEZD+SGnoq5Oc/6V/nen5vtlIcTgxnFTrWAhc9tLMoTPkYbFe6EMtCGCBihsfmDswn+jtMxVNRS
7iItCA==
--00000000000072b6ca058a32e4d1--
