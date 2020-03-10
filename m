Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2790917F5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCJLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:08:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgCJLIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:08:00 -0400
Received: from zn.tnic (p200300EC2F09B4000CCA2EEF87DC47A5.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:cca:2eef:87dc:47a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF4E61EC0273;
        Tue, 10 Mar 2020 12:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583838478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NLbmp6bW9B7OsLKSubj4LOvRjmIgDRbX4DKrnaThSj8=;
        b=ZySw3lnmctyl8oeUPZzrtCq2JhRmON6AyovzV9gGKlp/OcXDigwH4UHCnrBhGlH2irE8X4
        xSyRiOjcRh+tVgmMKAymn84+KtNuTQbtU6cbUCvsdccF+vDv7ub/vDUqPBuR/fKEtW+jyF
        bWeBJYlq8dTciyrngPgDuBLU8ccMjbU=
Date:   Tue, 10 Mar 2020 12:08:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch part-II V2 08/13] tracing: Provide lockdep less
 trace_hardirqs_on/off() variants
Message-ID: <20200310110802.GC29372@zn.tnic>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.731890049@linutronix.de>
 <07a50582-1c2f-7f45-c7dd-5ff9c2ff3052@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07a50582-1c2f-7f45-c7dd-5ff9c2ff3052@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:55:57AM +0100, Alexandre Chartre wrote:
> Shouldn't trace_hardirqs_on() be updated to call __trace_hardirqs_on()? It's the same
> code except for the lockdep call.

Fell into that one too initially. Look again. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
