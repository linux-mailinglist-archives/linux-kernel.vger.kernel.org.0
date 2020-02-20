Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06C1654CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 03:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBTCGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 21:06:14 -0500
Received: from sequoia-grove.ad.secure-endpoints.com ([208.125.0.235]:60207
        "EHLO sequoia-grove.secure-endpoints.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbgBTCGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:06:13 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 21:06:12 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
        d=auristor.com; s=MDaemon; t=1582163812; x=1582768612;
        i=jaltman@auristor.com; q=dns/txt; h=VBR-Info:Subject:To:Cc:
        References:From:Organization:Message-ID:Date:User-Agent:
        MIME-Version:In-Reply-To:Content-Type; bh=AsMhNEo1uxTpTVgxBTp/jD
        tZvdIlxzRztBJuWG2WBV4=; b=jOGE/T5G5+X+O1S+GGuNni/SEOTy3RKhtDNQVv
        P0UeyM+8oLc70zcOYjaNprdzru8fJUzL4ufgi6yH3YOv+6rUm8H+2LMfwveMxcVc
        pc7XyyR0YIYYWduhzRUsKagt4ajM/pPZxuXhN9xrlxVf14IZOR3QiHHfv0OxOD51
        27acg=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.secure-endpoints.com, Wed, 19 Feb 2020 20:56:52 -0500
Received: from [IPv6:2001:470:1f07:f77:7866:714b:778:2207] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v19.5.4) 
        with ESMTPSA id md50002310426.msg; Wed, 19 Feb 2020 20:56:50 -0500
VBR-Info: md=auristor.com; mc=all; mv=vbr.emailcertification.org;
X-Spam-Processed: sequoia-grove.secure-endpoints.com, Wed, 19 Feb 2020 20:56:50 -0500
        (not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2001:470:1f07:f77:7866:714b:778:2207
X-MDHelo: [IPv6:2001:470:1f07:f77:7866:714b:778:2207]
X-MDArrival-Date: Wed, 19 Feb 2020 20:56:50 -0500
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1319e7de82=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] afs: Create a mountpoint through symlink() and remove
 through rmdir()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <158215745745.386537.12978619503606431141.stgit@warthog.procyon.org.uk>
 <CAHk-=whOAg2EJycA=x=8RzBy3dnDFsgnyxrjREyNu6-8+eTTHA@mail.gmail.com>
From:   Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Message-ID: <5cd3f0c0-38b0-6929-5e27-c709c57a4d0f@auristor.com>
Date:   Wed, 19 Feb 2020 20:56:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whOAg2EJycA=x=8RzBy3dnDFsgnyxrjREyNu6-8+eTTHA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010204080504010802040201"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010204080504010802040201
Content-Type: multipart/mixed;
 boundary="------------F46869E628766733408B63A3"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F46869E628766733408B63A3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

response inline ...

On 2/19/2020 8:21 PM, Linus Torvalds wrote:
> On Wed, Feb 19, 2020 at 4:11 PM David Howells <dhowells@redhat.com> wro=
te:
>>
>> If symlink() is given a magic prefix in the target string, turn it int=
o a
>> mountpoint instead.
>>
>> The prefix is "//_afs3_mount:".
>=20
> That sounds sane.
>=20
> Your argument that if the prefix is made really long it couldn't be a
> valid symlink at all on AFS is fair, but seems somewhat excessive.

My understanding is that the prefix is not something that will be stored
on the server. Isn't the prefix intended to provide a namespace so that
a symlink target passed to a smb3/cifs filesystem can filter out the
invalid server name?

AFS symlinks have a maximum target string length of 1024 octets
including the trailing NUL.  The maximum cell name is 255 which matches
the maximum DNS name length.  The maximum volume name length is 255
in AuriStorFS and 31 in AFS3.

> The only issue I see with this interface is that you can now create
> these kinds of things by untarring a tar-ball etc.

There is no security issue here.  AFS volumes do not need to be mounted
in the /afs file namespace in order to access the volume's root
directory.  A mount point such as implemented here is just a reference
to a volume root.

OpenAFS provides a generic interface

  /afs/.:mount/<cell-name>:<volume-name-or-id>/

to access any volume's root directory and

  /afs/.:mount/<cell-name>:<volume-name-or-id>:<vnode-id>:<unique-id>

to access any AFS3 object by its object identifier whether its a
directory, file, symlink, etc.

Linux can of course mount arbitrary volumes using mount. For example:

 mount -t afs "#auristor.com:user.jaltman." /home/jaltman

There are existing AFS tools such as afs-up which clones a directory
tree from one place to another.  On Windows the AFS3 mount points and
symlinks are exposed as reparse points and can be copied from place to
place using tools such as Microsoft's robocopy; including to NTFS.

AFS3 mount points are also stored in AFS dump files which are similar to
tar files.

> I can see that being both very convenient and a possible security
> pain. But I'm assuming that the real security is on the server side
> anyway and not just anybody can create arbitrary things like these?

The security of AFS3 is provided by the enforcement of Access Controls
as interpreted by the AFS3 fileservers.  For OpenAFS the ACLs are stored
only on directories.  AuriStorFS cells enforce Volume ACLs and Object
ACLs which include ACLs on directories, files, symlinks and mount points.=


ACL interpretation is performed by evaluating the applicable ACLs
against the current protection set (user id and membership group ids)
attributed to the combined authentication identities bound to the RPC
request.

If curious,

 https://www.auristor.com/documentation/man/linux/7/auristorfs_acls.html

The computed rights granted to the caller are transmitted to the
requesting client as part of the status response.  This permits the
caller to cache the permissions along with the Callback promise.  The
permissions are discarded by the client when the Callback promise is
broken or expires.

Thanks for your assistance with refining the functional implementation.

Jeffrey Altman


--------------F46869E628766733408B63A3
Content-Type: text/x-vcard; charset=utf-8;
 name="jaltman.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="jaltman.vcf"

begin:vcard
fn:Jeffrey Altman
n:Altman;Jeffrey
org:AuriStor, Inc.
adr:;;255 W 94TH ST STE 6B;New York;NY;10025-6985;United States
email;internet:jaltman@auristor.com
title:CEO
tel;work:+1-212-769-9018
url:https://www.linkedin.com/in/jeffreyaltman/
version:2.1
end:vcard


--------------F46869E628766733408B63A3--

--------------ms010204080504010802040201
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DGswggXSMIIEuqADAgECAhBAAW0B1qVVQ32wvx2EXYU6MA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEy
MB4XDTE5MDkwNTE0MzE0N1oXDTIyMTEwMTE0MzE0N1owcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEMwMDAwMDE2RDAxRDZBNTQwMDAwMDQ0NDcxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCY1TC9QeWnUgEoJ81FcAVnhGn/AWuzvkYRUG5/ZyXDdaM212e8
ybCklgSmZweqNdrfaaHXk9vwjpvpD4YWgb07nJ1QBwlvRV/VPAaDdneIygJJWBCzaMVLttKO
0VimH/I/HUwFBQT2mrktucCEf2qogdi2P+p5nuhnhIUiyZ71Fo43gF6cuXIMV/1rBNIJDuwM
Q3H8zi6GL0p4mZFZDDKtbYq2l8+MNxFvMrYcLaJqejQNQRBuZVfv0Fq9pOGwNLAk19baIw3U
xdwx+bGpTtS63Py1/57MQ0W/ZXE/Ocnt1qoDLpJeZIuEBKgMcn5/iN9+Ro5zAuOBEKg34wBS
8QCTAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
Mi5wN2MwHwYDVR0jBBgwFoAUpHPa72k1inXMoBl7CDL4a4nkQuwwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTIuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBR7pHsvL4H5GdzNToI9e5BuzV19
bzAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAFlm
JYk4Ff1v/n0foZkv661W4LCRtroBaVykOXetrDDOQNK2N6JdTa146uIZVgBeU+S/0DLvJBKY
tkUHQ9ovjXJTsuCBmhIIw3YlHoFxbku0wHEpXMdFUHV3tUodFJJKF3MbC8j7dOMkag59/Mdz
Sjszdvit0av9nTxWs/tRKKtSQQlxtH34TouIke2UgP/Nn901QLOrJYJmtjzVz8DW3IYVxfci
SBHhbhJTdley5cuEzphELo5NR4gFjBNlxH7G57Hno9+EWILpx302FJMwTgodIBJbXLbPMHou
xQbOL2anOTUMKO8oH0QdQHCtC7hpgoQa7UJYJxDBI+PRaQ/HObkwggaRMIIEeaADAgECAhEA
+d5Wf8lNDHdw+WAbUtoVOzANBgkqhkiG9w0BAQsFADBKMQswCQYDVQQGEwJVUzESMBAGA1UE
ChMJSWRlblRydXN0MScwJQYDVQQDEx5JZGVuVHJ1c3QgQ29tbWVyY2lhbCBSb290IENBIDEw
HhcNMTUwMjE4MjIyNTE5WhcNMjMwMjE4MjIyNTE5WjA6MQswCQYDVQQGEwJVUzESMBAGA1UE
ChMJSWRlblRydXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExMjCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBANGRTTzPCic0kq5L6ZrUJWt5LE/n6tbPXPhGt2Egv7plJMoEpvVJ
JDqGqDYymaAsd8Hn9ZMAuKUEFdlx5PgCkfu7jL5zgiMNnAFVD9PyrsuF+poqmlxhlQ06sFY2
hbhQkVVQ00KCNgUzKcBUIvjv04w+fhNPkwGW5M7Ae5K5OGFGwOoRck9GG6MUVKvTNkBw2/vN
MOd29VGVTtR0tjH5PS5yDXss48Yl1P4hDStO2L4wTsW2P37QGD27//XGN8K6amWB6F2XOgff
/PmlQjQOORT95PmLkwwvma5nj0AS0CVp8kv0K2RHV7GonllKpFDMT0CkxMQKwoj+tWEWJTiD
KSsCAwEAAaOCAoAwggJ8MIGJBggrBgEFBQcBAQR9MHswMAYIKwYBBQUHMAGGJGh0dHA6Ly9j
b21tZXJjaWFsLm9jc3AuaWRlbnRydXN0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDovL3ZhbGlk
YXRpb24uaWRlbnRydXN0LmNvbS9yb290cy9jb21tZXJjaWFscm9vdGNhMS5wN2MwHwYDVR0j
BBgwFoAU7UQZwNPwBovupHu+QucmVMiONnYwDwYDVR0TAQH/BAUwAwEB/zCCASAGA1UdIASC
ARcwggETMIIBDwYEVR0gADCCAQUwggEBBggrBgEFBQcCAjCB9DBFFj5odHRwczovL3NlY3Vy
ZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDADAgEB
GoGqVGhpcyBUcnVzdElEIENlcnRpZmljYXRlIGhhcyBiZWVuIGlzc3VlZCBpbiBhY2NvcmRh
bmNlIHdpdGggSWRlblRydXN0J3MgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBQb2xpY3kgZm91bmQg
YXQgaHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3Rz
L2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRy
dXN0LmNvbS9jcmwvY29tbWVyY2lhbHJvb3RjYTEuY3JsMB0GA1UdJQQWMBQGCCsGAQUFBwMC
BggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0OBBYEFKRz2u9pNYp1zKAZewgy+GuJ
5ELsMA0GCSqGSIb3DQEBCwUAA4ICAQAN4YKu0vv062MZfg+xMSNUXYKvHwvZIk+6H1pUmivy
DI4I6A3wWzxlr83ZJm0oGIF6PBsbgKJ/fhyyIzb+vAYFJmyI8I/0mGlc+nIQNuV2XY8cypPo
VJKgpnzp/7cECXkX8R4NyPtEn8KecbNdGBdEaG4a7AkZ3ujlJofZqYdHxN29tZPdDlZ8fR36
/mAFeCEq0wOtOOc0Eyhs29+9MIZYjyxaPoTS+l8xLcuYX3RWlirRyH6RPfeAi5kySOEhG1qu
NHe06QIwpigjyFT6v/vRqoIBr7WpDOSt1VzXPVbSj1PcWBgkwyGKHlQUOuSbHbHcjOD8w8wH
SDbL+L2he8hNN54doy1e1wJHKmnfb0uBAeISoxRbJnMMWvgAlH5FVrQWlgajeH/6NbYbBSRx
ALuEOqEQepmJM6qz4oD2sxdq4GMN5adAdYEswkY/o0bRKyFXTD3mdqeRXce0jYQbWm7oapqS
ZBccFvUgYOrB78tB6c1bxIgaQKRShtWR1zMM0JfqUfD9u8Fg7G5SVO0IG/GcxkSvZeRjhYcb
TfqF2eAgprpyzLWmdr0mou3bv1Sq4OuBhmTQCnqxAXr4yVTRYHkp5lCvRgeJAme1OTVpVPth
/O7HJ7VuEP9GOr6kCXCXmjB4P3UJ2oU0NqfoQdcSSSt9hliALnExTEjii20B2nSDojGCAxQw
ggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMO
VHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowDQYJYIZIAWUDBAIBBQCgggGXMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDIyMDAxNTY0MFow
LwYJKoZIhvcNAQkEMSIEIKYMcJN0pY7eex6ITkC9v7Vv4zURRXF2qZNfFU+OAIK9MF0GCSsG
AQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UE
AxMOVHJ1c3RJRCBDQSBBMTICEEABbQHWpVVDfbC/HYRdhTowXwYLKoZIhvcNAQkQAgsxUKBO
MDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQg
Q0EgQTEyAhBAAW0B1qVVQ32wvx2EXYU6MGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEALB8kqIkOto9f
4YYhveV7aVsARnFSdd97MzelbEZMJDJLXKIjomMyLmNqI8NsLyQRjvdYpqVtxpQPObDeNBT8
HTxH9YfyDERB0y8wQRlWJLnKAUmv8Z8UXgsHkiYU46DDc9UQGCEOC9N989KthkgHCbS56an/
FVk0ayZTA9H/c4PqOCIsli9z67Vb2VBuij+4Equf2i4jY/8ROPbCW5OaANHTjulOO1EPlu3S
uUBa3kTz0pAPBoFzWk2tLncy2xHworA4psob0v34e3V3mHj9/J4DEB1f0T8pv1aDvhwxyxvV
toklkHiUKsKjBAZfudvw+v8sBTkCrb5hwB9SLCBTAgAAAAAAAA==
--------------ms010204080504010802040201--

