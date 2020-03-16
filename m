Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A76541867B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 10:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgCPJSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 05:18:37 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37067 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgCPJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:18:37 -0400
Received: by mail-vk1-f196.google.com with SMTP id o124so4642091vkc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xS1w6b9dGNxOYZgn4XqIsKqMFqWDeiCDvqlu4Cc2qb8=;
        b=xnDXV/hxwqGt009+I3FBwB8fLLhBVcO6v21MqAzIxBgCZ2q9ZUfSnVGKHDpIwcNUQX
         hajdIKjDWiM9wPD4n9GCOk3b6y5IcSF092I0S8x6fJGvW+sH42iV/J6WHM9tt+C7vEZF
         jl4oZ168qMMXgOXkw/govVYYtLVFcfaj7zpfmsnGvZRBTKj2u6j9B5mHyLqsYOMXkYFF
         JTZkazg1IZX9qDjyFtVdg/LZZ3snSKEHxReNjHW4pvikHuHLuBDckOwvR1nCSf6YvmgE
         zeXnBophhXqLmdmjTJWHkz93QXPukqVYXYyRZL5gFFM4sGb4e3pMhz8WegZ6w0EBSkV1
         uvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xS1w6b9dGNxOYZgn4XqIsKqMFqWDeiCDvqlu4Cc2qb8=;
        b=FRbATOEh7MoeQEJDd8mqjZL1pDtHEbQvkAJzIYG/rjG4OZHGc0okfJ7Aq5vTjq+aT6
         lt/axeOyUh+J0g5azMdG1PNmJRQ+hVgDsS0KWSO2Be7BW1DzpNo50Btm919458OMj0Bv
         nq1+CbPW8ItgtooPn87FtaOiBaSNavKxSx4zyso0rVvNhG2fm9Gs9G0LuLAwnGbS2y9f
         1RkeKxOyTSFIhIveXKvY3nxzZKGwSGNLAzMgyP1+bWQGk18qY1YlzyGGYCphi5GM/DwU
         F2gCD2r/27G1hKwlDC2dSkm+94OfUI99TJwAW2Rity943T3wMTey1mE2bAhomh8zkE6l
         QJfQ==
X-Gm-Message-State: ANhLgQ2vhmNN+v/noFRmsz8K3amiq78/1Q1ry5ic+/OztQzQK66x+pg7
        2vn4P2qeEIFs3dYwbyzHI231iiwzVyJcnjll8zIgFQ==
X-Google-Smtp-Source: ADFU+vu26XRxSxwCaT6vnRCiejRxHsSjxolFEGSMIeKbwDFbcaLA927cijTLnlzzA4QRtWQr/dvD7OnuZmcs91NIUaA=
X-Received: by 2002:a1f:a286:: with SMTP id l128mr15786621vke.31.1584350313783;
 Mon, 16 Mar 2020 02:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200312083341.9365-1-jian-hong@endlessm.com> <20200312104643.GA15619@zn.tnic>
In-Reply-To: <20200312104643.GA15619@zn.tnic>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 16 Mar 2020 17:17:56 +0800
Message-ID: <CAPpJ_eetjhmPwXXXn2y-vibRCK6rrKsFZgC+YGzxO4fMrCKpuQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> =E6=96=BC 2020=E5=B9=B43=E6=9C=8812=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Mar 12, 2020 at 04:33:42PM +0800, Jian-Hong Pan wrote:
> > This reverts commit 0082517fa4bce073e7cf542633439f26538a14cc.
> >
> > According to Acer's information, this reboot issue is fixed since 1.08
> > and newer BIOS. So, we can revert the quirk.
>
> We can?
>
> How do you know *everyone* affected will update their BIOS?
>
> And what's the downside of keeping it?

Good question!
How about add DMI_BIOS_VERSION for BIOS DMI_MATCH.  For example,
DMI_MATCH(DMI_BIOS_VERSION, "V1.0")

The BIOS versions listed on Acer website [1] are 1.04, 1.10 ...
The reboot issue is fixed since BIOS 1.08.  So, the only the string
like "V1.0*" should apply the quirk.

But, that will raise another question:  Since the original quirk works
for all Acer X514-51T and the quirk cannot be removed for older BIOS.
Why not keep only original matching items for all Acer X514-51T
laptops?

I am not sure which option is better.  Any comment?

[1] https://www.acer.com/ac/en/US/content/support-product/7889?b=3D1

BR,
Jian-Hong Pan
