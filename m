Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA059195B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 17:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgC0Qwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 12:52:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:47328 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgC0Qwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:52:43 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1890B2E4;
        Fri, 27 Mar 2020 16:52:43 +0000 (UTC)
Date:   Fri, 27 Mar 2020 10:52:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: x86: exception-tables: document
 CONFIG_BUILDTIME_TABLE_SORT
Message-ID: <20200327105242.20a6d20e@lwn.net>
In-Reply-To: <20200327000951.84071-1-ndesaulniers@google.com>
References: <6e26c798-1439-2bbd-6801-8fd21c4e6926@zytor.com>
        <20200327000951.84071-1-ndesaulniers@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 17:09:51 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> Provide more information about __ex_table sorting post link.
> 
> The exception tables and fixup tables use a commonly recurring pattern
> in the kernel of storing the address of labels as date in custom ELF
> sections, then finding these sections, iterating elements within them,
> and possibly revisiting them or modifying the data at these addresses.
> 
> Sorting readonly arrays to minimize runtime penalties is quite clever.
> 
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I've applied this, thanks.

jon
