Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF28E2863A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfEWTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 15:01:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:35838 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731261AbfEWTBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:01:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D42AAB5;
        Thu, 23 May 2019 19:01:02 +0000 (UTC)
Date:   Thu, 23 May 2019 13:01:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, tglx@linutronix.de, mingo@kernel.org,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH v3] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190523130101.1f6cc121@lwn.net>
In-Reply-To: <20190523143703.2fb71f71@gandalf.local.home>
References: <1558405928-29449-1-git-send-email-zhenzhong.duan@oracle.com>
        <20190523143703.2fb71f71@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 14:37:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 21 May 2019 10:32:08 +0800
> Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
> 
> > The default behavior of hardlockup depends on the config of
> > CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
> >   
> 
> Jon,
> 
> You want to take this in your tree?

Sure, I'll take it.

Thanks,

jon
