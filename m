Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1A1684E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBUR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 12:26:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42988 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgBUR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:26:17 -0500
Received: from zn.tnic (p200300EC2F090A002034B94CF5910173.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:2034:b94c:f591:173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B94441EC0591;
        Fri, 21 Feb 2020 18:26:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582305975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ux0GEY+Iwsw38URwfJVMeEYqbnqDCSe7QtkDeSxHdgk=;
        b=gh7Zl8K4VO07gkAP7kQQoLOgccbH03cGy0s8FmUJFP3NSSfL4h/TG3uvpFO5JvaGNHv97V
        6cS6A4cmbE8e1NfKGNxPJG5tJYfSgS6zqvWzM+0ZDSlHRB3Zbz8f4nppDE8pMBMrQIYo9z
        sBdYtKMNkJ1pzTjd3hfkoTeuyDfzR4E=
Date:   Fri, 21 Feb 2020 18:26:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 0/1] drm: Add DRM_MODE_TYPE_USERDEF flag to probed
 modes
Message-ID: <20200221172611.GK25747@zn.tnic>
References: <20200221172209.509686-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221172209.509686-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 06:22:08PM +0100, Hans de Goede wrote:
> Hi All,
> 
> I'm resending this patch since the discussion on it has fallen
> silent for a while now.

Might fall silent this time too with those recipients. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
