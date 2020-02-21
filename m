Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4491A1689A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBUV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:58:29 -0500
Received: from ms.lwn.net ([45.79.88.28]:59224 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgBUV62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:58:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E8EF14A8;
        Fri, 21 Feb 2020 21:58:24 +0000 (UTC)
Date:   Fri, 21 Feb 2020 14:58:18 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove MPX from the x86 toc
Message-ID: <20200221145818.2dc36f94@lwn.net>
In-Reply-To: <20200221225642.006495c9@heffalump.sk2.org>
References: <20200221205733.26351-1-steve@sk2.org>
        <cc401ede-c94e-3688-5295-fd4d4a1806a4@intel.com>
        <20200221225642.006495c9@heffalump.sk2.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 22:56:42 +0100
Stephen Kitt <steve@sk2.org> wrote:

> > Fixes: 45fc24e89b7cc ("x86/mpx: remove MPX from arch/x86")  
> 
> Ah yes, it would be. What’s the etiquette here? Should I respin, or can
> whoever merges this (Jon?) add this to the commit message?

I can add it, no worries.

Thanks,

jon
