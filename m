Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D3E135C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbfJWHqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 03:46:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55526 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732328AbfJWHqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:46:04 -0400
Received: from zn.tnic (p200300EC2F11E8005961F1FA34C94581.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:e800:5961:f1fa:34c9:4581])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B69C01EC0C97;
        Wed, 23 Oct 2019 09:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571816763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=33x7ICr9fxs1J4Vu9qmTnOIG8Qr9Paia3taGadlBeds=;
        b=sF90pXPOJvEOtqF8Zq0yKWXrr3MeSgzvDQ0HYHx+rjLoH2+4RmK73uq/jUqNeB7aEDtm8x
        IX9nXFmsaljQqV1fzFtTxdjFv0qD5Kd+xBedwsBx7DzFAkf8jpWYIp6dg6Fr60NnWP4NUg
        Lo3n0JOPGdzv4oLF6joYAx1XUFfSmyc=
Date:   Wed, 23 Oct 2019 09:46:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191023074602.GB16060@zn.tnic>
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com>
 <20191022083015.GB31700@zn.tnic>
 <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:35:09PM +0800, lijiang wrote:
> Would you mind if i improve this patch as follow? Thanks.

Yap, looks good to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
