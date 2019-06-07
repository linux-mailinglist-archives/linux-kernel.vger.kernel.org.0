Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA80C393A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfFGRuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 13:50:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:57950 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGRuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:50:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB8C9737;
        Fri,  7 Jun 2019 17:50:48 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:50:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>, Jann Horn <jannh@google.com>,
        Nadav Amit <namit@vmware.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] treewide: trivial: fix s/poped/popped/ typo
Message-ID: <20190607115047.2d6e1eb5@lwn.net>
In-Reply-To: <1559766612-12178-2-git-send-email-george_davis@mentor.com>
References: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
        <1559766612-12178-2-git-send-email-george_davis@mentor.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 16:30:10 -0400
"George G. Davis" <george_davis@mentor.com> wrote:

> Fix a couple of s/poped/popped/ typos.
> 
> Cc: Jiri Kosina <trivial@kernel.org>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

I've applied this one, thanks.

jon
