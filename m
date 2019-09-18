Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF8B654B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfIROAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 10:00:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38069 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfIROAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:00:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so5780358lfc.5;
        Wed, 18 Sep 2019 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Gjuy2BobqTtYzcRJC3yYgBOZPPiT0+Q2NlOyo4yVn/g=;
        b=ERA9bZLBrzVs82xSZNivXvDKvb3FTqbg8kJE+kceqpXcvg/brCo9l0dCNKW9cT2w+9
         hwSw/inM1QPgrbcNjENefgmVnQQ1IFnh8Pa+0x0iy57TQjmoeRA54g95HDHWoDCo9PMe
         K0MLhf70r2xOd3UMXz2L6dmAHVV1UjpDB1Nw+pSQWt0VKVr28R+FsXNOfSqfO0y9ho6S
         phiTm9p57QhUCv53sFjx8wljoCdSN3lAqaQ+d/Do7W2JTGYxqa8HMWZvKE4OLTGj/5HL
         UJeLgEUKouCY/qHwfKOktZ0Lhqi3uLPZKie2Z2JFMsuo+rIIutwk8IRo/5Q9k9sdAy1w
         wazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Gjuy2BobqTtYzcRJC3yYgBOZPPiT0+Q2NlOyo4yVn/g=;
        b=EbTM6nMtGcSYbYC8x8qanw4enhuulkoJGbG9R+mBE3zR/qhb+hjav5FHEaqAprCNiB
         mLKE/V8po54ggK9JgTf5vO7OETnn8dmHwF/AjaS0K3Nm3QH59UAP+840nNsY+5m45j9+
         a8q5Ioy8EeBYSsHXh97j6K2gscVlTV0pnOzRfcVUFAT3cap6SzRm7lMK0m/dxrwCRlKP
         uSK+iQJfazLvqxkas50goPQEizFJaqiXDWIE61KRkcqmHqVotrP2zHrGBfrrDnJ8Cvo5
         qdgDFqUwnD2ZYL+f+fyvBlvhBfite1MbXVfvUVFiPsDQ0kZ3rKnXNB0kgozcidDs3R1R
         NCzA==
X-Gm-Message-State: APjAAAXVTW8/0UeEYU0GllSBx4WTtCPM2K3rGmaFZEadZ8aErg7PUbA1
        cOZ7qAjAwGnI7j7ljC+fEv5812oqdFqeGPq4
X-Google-Smtp-Source: APXvYqxHD9zCTNeJeKVgV36B4dJ+3O3sYwtWvVOPBUZCQCnPclJi8xUh18uHb3BhB5WYll4vKnri8w==
X-Received: by 2002:a19:c14a:: with SMTP id r71mr2198196lff.55.1568815204787;
        Wed, 18 Sep 2019 07:00:04 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::47f? ([2a02:17d0:4a6:5700::47f])
        by smtp.googlemail.com with ESMTPSA id f21sm1207295lfm.90.2019.09.18.07.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:00:03 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     Lennart Poettering <mzxreary@0pointer.de>, Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu> <20190917155743.GB31567@gardel-login>
 <20190917162137.GA27921@1wt.eu> <20190917171328.GA31798@gardel-login>
 <20190917172929.GD27999@1wt.eu> <20190918133806.GA32346@gardel-login>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <dde9545e-66a7-f9cc-7b03-63517c4f8655@gmail.com>
Date:   Wed, 18 Sep 2019 18:59:31 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918133806.GA32346@gardel-login>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000105010902080405070607"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000105010902080405070607
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: quoted-printable

18.09.2019 18:38, Lennart Poettering =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Di, 17.09.19 19:29, Willy Tarreau (w@1wt.eu) wrote:
>=20
>>> What do you expect these systems to do though?
>>>
>>> I mean, think about general purpose distros: they put together live
>>> images that are supposed to work on a myriad of similar (as in: same
>>> arch) but otherwise very different systems (i.e. VMs that might lack
>>> any form of RNG source the same as beefy servers with muliple sources=

>>> the same as older netbooks with few and crappy sources, ...). They ca=
n't
>>> know what the specific hw will provide or won't. It's not their
>>> incompetence that they build the image like that. It's a common, very=

>>> common usecase to install a system via SSH, and it's also very common=

>>> to have very generic images for a large number varied systems to run
>>> on.
>>
>> I'm totally file with installing the system via SSH, using a temporary=

>> SSH key. I do make a strong distinction between the installation phase=

>> and the final deployment. The SSH key used *for installation* doesn't
>> need to the be same as the final one. And very often at the end of the=

>> installation we'll have produced enough entropy to produce a correct
>> key.
>=20
> That's not how systems are built today though. And I am not sure they
> should be. I mean, the majority of systems at this point probably have
> some form of hardware (or virtualized) RNG available (even raspi has
> one these days!), so generating these keys once at boot is totally
> OK. Probably a number of others need just a few seconds to get the
> entropy needed, where things are totally OK too. The only problem is
> systems that lack any reasonable source of entropy and where
> initialization of the pool will take overly long.
>=20
> I figure we can reduce the number of systems where entropy is scarce
> quite a bit if we'd start crediting entropy by default from various hw
> rngs we currently don't credit entropy for. For example, the TPM and
> older intel/amd chipsets. You currently have to specify
> rng_core.default_quality=3D1000 on the kernel cmdline to make them
> credit entropy. I am pretty sure this should be the default now, in a
> world where CONFIG_RANDOM_TRUST_CPU=3Dy is set anyway. i.e. why say
> RDRAND is fine but those chipsets are not? That makes no sense to me.
>=20
> I am very sure that crediting entropy to chipset hwrngs is a much
> better way to solve the issue on those systems than to just hand out
> rubbish randomness.

Very well said. However, 1000 is more than the hard-coded quality of=20
some existing rngs, and so would send a misleading message that they are =

somehow worse. I would suggest case-by-case reevaluation of all existing =

hwrng drivers by their maintainers, and then setting the default to=20
something like 899, so that evaluated drivers have priority.

--=20
Alexander E. Patrakov


--------------ms000105010902080405070607
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Криптографическая подпись S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
C5wwggVNMIIENaADAgECAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3DQEBCwUAMIGCMQsw
CQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoM
GkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBB
dXRoZW50aWNhdGlvbiBDQSBHMTAeFw0xOTA2MDYwODAxMzVaFw0yMDA2MDYwODAxMzVaMB0x
GzAZBgNVBAMMEnBhdHJha292QGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAOA0sb1ubDnIK32rbgW3BnjBcx1pYuEFOCU6aPVJ2gU+wtKJgAo9IdVUXG6kC1fF
hXjIcZHOgbEqzFjHK1yXlHIUWEv+N8KdmBDOK1UdKQj58d9A4hnH62iEiwQsOR5YT1UyHX4A
pfMjsBja7254cixR4jOPzfA4YUD6JTTPioyjDwuYQlhweVyXziKswLtGWfKeDcm3fOlKYxGy
hxjWJRamGTreNBVC9uMkF4DHszpUm07agR2U4mnWy7FsjBuRJ++iX0SvuxKWf19HQWgmgIys
jBVrArhVzgjOOnbvlklW849wIARF4Y0WAf91DsqPtuR8hu7+9KIVj2qk9BeNXXUCAwEAAaOC
AiEwggIdMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUfmD8+GynPT3XrpOheQKPs3QpO/Uw
SwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vY2FjZXJ0LmFjdGFsaXMuaXQv
Y2VydHMvYWN0YWxpcy1hdXRjbGlnMTAdBgNVHREEFjAUgRJwYXRyYWtvdkBnbWFpbC5jb20w
RwYDVR0gBEAwPjA8BgYrgR8BGAEwMjAwBggrBgEFBQcCARYkaHR0cHM6Ly93d3cuYWN0YWxp
cy5pdC9hcmVhLWRvd25sb2FkMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDCB6AYD
VR0fBIHgMIHdMIGboIGYoIGVhoGSbGRhcDovL2xkYXAwNS5hY3RhbGlzLml0L2NuJTNkQWN0
YWxpcyUyMENsaWVudCUyMEF1dGhlbnRpY2F0aW9uJTIwQ0ElMjBHMSxvJTNkQWN0YWxpcyUy
MFMucC5BLi8wMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDti
aW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSENM
LUcxL2dldExhc3RDUkwwHQYDVR0OBBYEFEhX9pz3jwI3+erfsAVB2b4xSsM8MA4GA1UdDwEB
/wQEAwIFoDANBgkqhkiG9w0BAQsFAAOCAQEAVbKht9PGiUsUaqiyzJb6blSMNaLwopQr3AsI
FvthyqnSqxmSNYDeZsQYPgBnXvMCvHCn07pm1b96Y3XstBt2FWb9dpDr7y+ec3vxFHb3lKGb
3WREB1kEATnBu2++dPcILG58gdzgYde3RAJC3/OyOZhDqKwQA5CnXTHigTzw75iezdLne5pU
MjEQoxdqC+sgbrAueaEpMmRsGSKzgIX8eQ3DWwyIL56fYPJP3u4WZmBUKTFhhUWowG62QLtt
ZjkiX/j+vjcSRd2app8lYDwQRornZAqrDxy+c4qQJ5FN234p36opwespDCwLN3Z6wPzLvzS+
jAlmV3DF2xuZGMoebzCCBkcwggQvoAMCAQICCCzUitOxHg+JMA0GCSqGSIb3DQEBCwUAMGsx
CzAJBgNVBAYTAklUMQ4wDAYDVQQHDAVNaWxhbjEjMCEGA1UECgwaQWN0YWxpcyBTLnAuQS4v
MDMzNTg1MjA5NjcxJzAlBgNVBAMMHkFjdGFsaXMgQXV0aGVudGljYXRpb24gUm9vdCBDQTAe
Fw0xNTA1MTQwNzE0MTVaFw0zMDA1MTQwNzE0MTVaMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UE
CAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAz
MzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMD8wYlW2Yji9ARlv80JNasoKTD+
DMr3J6scEe6GPV3k9WxEtgxXM5WX3oiKjS2p25Mqk8cnV2fpMaEvdO9alrGes0vqcUqly7Pk
U753RGlseYXR2XCjVhs4cuRYjuBmbxpRSJxRImmPnThKY41r0nl6b3A6Z2MOjPQF7h6OCYYw
tz/ziv/+UBV587U2uIlOukaS7Xjk4ArYkQsGTSsfBBXqqn06WL3xG+B/dRO5/mOtY5tHdhPH
ydsBk2kksI3PJ0yNgKV7o6HM7pG9pB6sGhj96uVLnnVnJ0WXOuV1ISv2eit9ir60LjT99hf+
TMZLxA5yaVJ57fYjBMbxM599cw0CAwEAAaOCAdUwggHRMEEGCCsGAQUFBwEBBDUwMzAxBggr
BgEFBQcwAYYlaHR0cDovL29jc3AwNS5hY3RhbGlzLml0L1ZBL0FVVEgtUk9PVDAdBgNVHQ4E
FgQUfmD8+GynPT3XrpOheQKPs3QpO/UwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRS
2Ig6yJ94Zu2J83s4cJTJAgI20DBFBgNVHSAEPjA8MDoGBFUdIAAwMjAwBggrBgEFBQcCARYk
aHR0cHM6Ly93d3cuYWN0YWxpcy5pdC9hcmVhLWRvd25sb2FkMIHjBgNVHR8EgdswgdgwgZag
gZOggZCGgY1sZGFwOi8vbGRhcDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVu
dGljYXRpb24lMjBSb290JTIwQ0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2
NyxjJTNkSVQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6
Ly9jcmwwNS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwDgYD
VR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQBNk87VJL5BG0oWWHNfZYny2Xo+WIy8
y8QP5VsWZ7LBS6Qz8kn8zJp3c9xdOkudZbcA3vm5U8HKXc1JdzNmpSh92zq/OeZLvUa+rnnc
mvhxkFE9Doag6NitggBPZwXHwDcYn430/F8wqAt3LX/bsd6INVrhPFk3C2SoAjLjUQZibXvQ
uFINMN4l6j86vCrkUaGzSqnXT45NxIivkAPhBQgpGtcTi4f+3DxkyTDbWtf9LuaC4l2jgB3g
C7f56nmdpGfpYsyvKE7+Ip+WryH93pWt6C+r68KU3Gu02cU1/dHvNOXWUDeKkVT3T26wZVrT
aMx+0nS3i63KDfJdhFzutfdBgCWHcp03NhOhMqy1RnAylF/dVZgkka6hKaWe1tOU21kS4uvs
D4wM5k6tl0pin2o6u47kyoJJMOxRSQcosWtDXUmaLHUG91ZC6hvBDmDmpmS6h/r+7mtPrpYO
xTr4hW3me2EfXkTvNTvBQtbi4LrZchg9vhi44EJ7L53g7GzQFn5KK8vqqgMb1c1+T0mkKdqS
edgGiB9TDdYtv4HkUj/N00TKxZMLiDMw4V8ShUL6bKTXNfb3E68s47cD+MatFjUuGFj0uFPv
ZlvlNAoJ7IMfXzIiTWy35X+akm+d49wBh54yv6icz2t/cBU1y1weuPBd8NUH/Ue3mXk0SXwk
GP3yVDGCA/YwggPyAgEBMIGXMIGCMQswCQYDVQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8w
DQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFjdGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSww
KgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4r
qg9tGyNesDANBglghkgBZQMEAgEFAKCCAi8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMTkwOTE4MTM1OTMxWjAvBgkqhkiG9w0BCQQxIgQg0ABwLtZqlrbB
DF4K0AGIgXqPH3rTfJYzFePusBIiOpIwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASow
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBqAYJKwYBBAGCNxAEMYGaMIGXMIGCMQswCQYD
VQQGEwJJVDEPMA0GA1UECAwGTWlsYW5vMQ8wDQYDVQQHDAZNaWxhbm8xIzAhBgNVBAoMGkFj
dGFsaXMgUy5wLkEuLzAzMzU4NTIwOTY3MSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBDQSBHMQIQK0NjfYTmoz4rqg9tGyNesDCBqgYLKoZIhvcNAQkQAgsxgZqg
gZcwgYIxCzAJBgNVBAYTAklUMQ8wDQYDVQQIDAZNaWxhbm8xDzANBgNVBAcMBk1pbGFubzEj
MCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5NjcxLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEcxAhArQ2N9hOajPiuqD20bI16wMA0GCSqGSIb3
DQEBAQUABIIBAHc9Ivarn8a1Ygy+MGRnrnowoT2FMXnjwVjtFw8S4xyhDj8MoQLZOVSAikX/
Sk/rz4eJfxuSF/plpLF1zVF7zj0QU0ccyVqwnUvPL5Ie7RRln0H0JkVTG5VXM7NWkcWg7cje
eHogVIM8kGJ58lxGEZwVWvPFNC0U2k0rIvtGbSaReL/V473FG2k2wbu9cKxG+fWvC8ognaXp
hIyIGoD9+Wqe1TZECNipK9HyJ7IRBkWU4zOjdwN/UW5wD+V+0+kXiZVFUPrfZMwT67mbTOFA
pwxTs9QwrCr7jv2zajvS/qbS4BDKfdlrKai6cdSjiG3NmIijDuBwercsEYAbvVPQp/AAAAAA
AAA=
--------------ms000105010902080405070607--
