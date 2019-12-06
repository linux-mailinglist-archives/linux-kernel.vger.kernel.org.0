Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAE115081
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 07:41:36 -0500
Received: from foss.arm.com ([217.140.110.172]:42342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:41:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B9B831B;
        Fri,  6 Dec 2019 04:41:35 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A62543F52E;
        Fri,  6 Dec 2019 04:41:34 -0800 (PST)
Date:   Fri, 6 Dec 2019 12:41:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Torsten Duwe <duwe@lst.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: arch/arm64/kernel/entry-ftrace.S:238: undefined reference to
 `ftrace_graph_caller'
Message-ID: <20191206124129.GA21671@lakrids.cambridge.arm.com>
References: <201912061533.I9JjEoWz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912061533.I9JjEoWz%lkp@intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 03:08:40PM +0800, kbuild test robot wrote:
> Hi Torsten,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b0d4beaa5a4b7d31070c41c2e50740304a3f1138
> commit: 3b23e4991fb66f6d152f9055ede271a726ef9f21 arm64: implement ftrace with regs

> All errors (new ones prefixed by >>):
> 
>    arch/arm64/kernel/entry-ftrace.o: In function `skip_ftrace_call':
> >> arch/arm64/kernel/entry-ftrace.S:238: undefined reference to `ftrace_graph_caller'
>    arch/arm64/kernel/entry-ftrace.S:238:(.text+0x3c): relocation truncated to fit: R_AARCH64_CONDBR19 against undefined symbol `ftrace_graph_caller'
>    arch/arm64/kernel/entry-ftrace.S:243: undefined reference to `ftrace_graph_caller'
>    arch/arm64/kernel/entry-ftrace.S:243:(.text+0x54): relocation truncated to fit: R_AARCH64_CONDBR19 against undefined symbol `ftrace_graph_caller'

This is my bad; I messed up the ifdeffery so that ftrace_graph_caller
isn't defined for CONFIG_DYNAMIC_FTRACE && CONFIG_FUNCTION_GRAPH_TRACER.

I will send a patch shortly. Sorry about this.

Mark.
