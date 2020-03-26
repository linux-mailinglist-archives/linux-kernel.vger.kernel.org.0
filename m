Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6271949AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 22:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCZVAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 17:00:07 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21192 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585256367; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WRjkVTXn35pW4fqXiV4NQyf+RjZYdT6/HcgD3SPZ5WbVb9IawvpsFu/WPxFqGuAa6TyhT6cYFt8Z1WS6polyuuEc8BkoZxz2OVLWFJKLwhrNQSFq8rGyXBw1N9Kggw25Py7jQjKg1QMteuWC2ABqxtIxAcKnT0J12m/51pZEUHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585256367; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=C5e6VkdIdyRsBsZRCvwZOcD82cThbdjQuOw5lATt7/Q=; 
        b=UhR3XIG+FpPHTOBQTf8g8zb+5nB82lLxbk61ZKYazXFq1xrGDz/p9sIeuAhD2IWG+b5SGqiZcHMzxZ5GbWBbk3UtCvNe0xigpdPLNo0Wy0Jq3P93+l2V/Ct12ARmYMXsILKSbn0b/O3FcffcQpfi3jSkTrJFWCG8Ixa9pGfaVWg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585256367;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=C5e6VkdIdyRsBsZRCvwZOcD82cThbdjQuOw5lATt7/Q=;
        b=cir/k/+81riZQC/mHn8w0FbtuNNg68q5ywRRBeqySaQ4IWT3bzxqPI2R46KI5AL+
        I2KUStN3X6SHo+ap8heWfYNMKO4OzAtXdJy/Fl3tl2kiZfufNHv+x9TcIY48PDv5TlL
        sw1FxRx689F7a/jWisrm8gKAZ0CaVvhGt6YqQ6OY=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585256364854143.1300313674102; Thu, 26 Mar 2020 13:59:24 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel
 support
To:     Matthew Garrett <mjg59@google.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        trenchboot-devel@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>, leif@nuviainc.com,
        eric.snowberg@oracle.com, piotr.krol@3mdeb.com,
        krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        andrew.cooper3@citrix.com
References: <CACdnJutT1F7YJ5KFkyuaZv=nj8GqC+mrnoAsHZfMP1ZRNUQg3Q@mail.gmail.com>
 <FE871C2B-15BB-4089-A912-40F2E9FE680B@amacapital.net>
 <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <7e5fdc3a-c32c-5a1e-60c0-7e0c6e319a6d@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 mQMuBFYrueARCACPWL3r2bCSI6TrkIE/aRzj4ksFYPzLkJbWLZGBRlv7HQLvs6i/K4y/b4fs
 JDq5eL4e9BdfdnZm/b+K+Gweyc0Px2poDWwKVTFFRgxKWq9R7McwNnvuZ4nyXJBVn7PTEn/Z
 G7D08iZg94ZsnUdeXfgYdJrqmdiWA6iX9u84ARHUtb0K4r5WpLUMcQ8PVmnv1vVrs/3Wy/Rb
 foxebZNWxgUiSx+d02e3Ad0aEIur1SYXXv71mqKwyi/40CBSHq2jk9eF6zmEhaoFi5+MMMgX
 X0i+fcBkvmT0N88W4yCtHhHQds+RDbTPLGm8NBVJb7R5zbJmuQX7ADBVuNYIU8hx3dF3AQCm
 601w0oZJ0jGOV1vXQgHqZYJGHg5wuImhzhZJCRESIwf+PJxik7TJOgBicko1hUVOxJBZxoe0
 x+/SO6tn+s8wKlR1Yxy8gYN9ZRqV2I83JsWZbBXMG1kLzV0SAfk/wq0PAppA1VzrQ3JqXg7T
 MZ3tFgxvxkYqUP11tO2vrgys+InkZAfjBVMjqXWHokyQPpihUaW0a8mr40w9Qui6DoJj7+Gg
 DtDWDZ7Zcn2hoyrypuht88rUuh1JuGYD434Q6qwQjUDlY+4lgrUxKdMD8R7JJWt38MNlTWvy
 rMVscvZUNc7gxcmnFUn41NPSKqzp4DDRbmf37Iz/fL7i01y7IGFTXaYaF3nEACyIUTr/xxi+
 MD1FVtEtJncZNkRn7WBcVFGKMAf+NEeaeQdGYQ6mGgk++i/vJZxkrC/a9ZXme7BhWRP485U5
 sXpFoGjdpMn4VlC7TFk2qsnJi3yF0pXCKVRy1ukEls8o+4PF2JiKrtkCrWCimB6jxGPIG3lk
 3SuKVS/din3RHz+7Sr1lXWFcGYDENmPd/jTwr1A1FiHrSj+u21hnJEHi8eTa9029F1KRfocp
 ig+k0zUEKmFPDabpanI323O5Tahsy7hwf2WOQwTDLvQ+eqQu40wbb6NocmCNFjtRhNZWGKJS
 b5GrGDGu/No5U6w73adighEuNcCSNBsLyUe48CE0uTO7eAL6Vd+2k28ezi6XY4Y0mgASJslb
 NwW54LzSSLQuRGFuaWVsIFAuIFNtaXRoIDxkcHNtaXRoQGFwZXJ0dXNzb2x1dGlvbnMuY29t
 Poh6BBMRCAAiBQJWK7ngAhsjBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBTc6WbYpR8
 KrQ9AP94+xjtFfJ8gj5c7PVx06Zv9rcmFUqQspZ5wSEkvxOuQQEAg6qEsPYegI7iByLVzNEg
 7B7fUG7pqWIfMqFwFghYhQy5Ag0EViu54BAIAL6MXXNlrJ5tRUf+KMBtVz1LJQZRt/uxWrCb
 T06nZjnbp2UcceuYNbISOVHGXTzu38r55YzpkEA8eURQf+5hjtvlrOiHxvpD+Z6WcpV6rrMB
 kcAKWiZTQihW2HoGgVB3gwG9dCh+n0X5OzliAMiGK2a5iqnIZi3o0SeW6aME94bSkTkuj6/7
 OmH9KAzK8UnlhfkoMg3tXW8L6/5CGn2VyrjbB/rcrbIR4mCQ+yCUlocuOjFCJhBd10AG1IcX
 OXUa/ux+/OAV9S5mkr5Fh3kQxYCTcTRt8RY7+of9RGBk10txi94dXiU2SjPbassvagvu/hEi
 twNHms8rpkSJIeeq0/cAAwUH/jV3tXpaYubwcL2tkk5ggL9Do+/Yo2WPzXmbp8vDiJPCvSJW
 rz2NrYkd/RoX+42DGqjfu8Y04F9XehN1zZAFmCDUqBMa4tEJ7kOT1FKJTqzNVcgeKNBGcT7q
 27+wsqbAerM4A0X/F/ctjYcKwNtXck1Bmd/T8kiw2IgyeOC+cjyTOSwKJr2gCwZXGi5g+2V8
 NhJ8n72ISPnOh5KCMoAJXmCF+SYaJ6hIIFARmnuessCIGw4ylCRIU/TiXK94soilx5aCqb1z
 ke943EIUts9CmFAHt8cNPYOPRd20pPu4VFNBuT4fv9Ys0iv0XGCEP+sos7/pgJ3gV3pCOric
 p15jV4OIYQQYEQgACQUCViu54AIbDAAKCRBTc6WbYpR8Khu7AP9NJrBUn94C/3PeNbtQlEGZ
 NV46Mx5HF0P27lH3sFpNrwD/dVdZ5PCnHQYBZ287ZxVfVr4Zuxjo5yJbRjT93Hl0vMY=
Date:   Thu, 26 Mar 2020 16:59:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACdnJusd7m-c0zLmAjSq9Sb9HxyCkhyyp5W=4FMdysgu7_g=Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 4:40 PM, Matthew Garrett wrote:
> On Thu, Mar 26, 2020 at 1:33 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>> As a straw-man approach: make the rule that we never call EFI after secu=
re launch. Instead we write out any firmware variables that we want to chan=
ge on disk somewhere.  When we want to commit those changes, we reboot, com=
mit the changes, and re-launch. Or we deactivate the kernel kexec-style, se=
al the image against PCRs, blow away PCRs, call EFI, relaunch, unseal the P=
CRs, and continue on our merry way.
>=20
> That breaks the memory overwrite protection code, where a variable is
> set at boot and cleared on a controlled reboot. We'd also need to read
> every variable and pass those values to the kernel in some way so the
> read interfaces still work. Some platforms may also expect to be able
> to use the EFI reboot call. As for the second approach - how would we
> verify that the EFI code hadn't modified any user pages? Those
> wouldn't be measured during the second secure launch. If we're calling
> the code at runtime then I think we need to assert that it's trusted.
>=20
>> I=E2=80=99m not sure how SMM fits in to this whole mess.
>=20
> SMM's basically an unsolved problem, which makes the whole DRTM
> approach somewhat questionable unless you include the whole firmware
> in the TCB, which is kind of what we're trying to get away from.

Yes and no. First, if you have a TXT-aware STM, then its solved (as
solved as it can be). But if you are not that luck(?) it is still not
possible for SMM to disrupt the initial measurements and thus the load
time integrity but it can tamper with the runtime integrity of the
kernel. But again everyone has acknowledge that if SMM is owned its game
over regardless. If EFI is corrupted then launching with Dynamic Launch
and not using Runtime Services, you will not be exposed, i.e. we have
contained the corruption.

An open question I have is whether it might be possible to re-establish
the integrity of runtime services by using a dynamically launched kernel.


>> If we insist on allowing EFI calls and SMM, then we may be able to *meas=
ure* our exposure to potentially malicious firmware, but we can=E2=80=99t e=
liminate it. I personally trust OEM firmware about as far as I can throw it=
.


