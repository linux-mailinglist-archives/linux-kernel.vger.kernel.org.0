Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF881666AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgBTSyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 13:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgBTSyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:54:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181D4206F4;
        Thu, 20 Feb 2020 18:54:53 +0000 (UTC)
Date:   Thu, 20 Feb 2020 13:54:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com,
        tstoyanov@vmware.com, andriy.shevchenko@intel.com,
        cezary.rojewski@intel.com, gustaw.lewandowski@intel.com
Subject: Re: [PATCH v2] libtraceevent: add __print_hex_dump support
Message-ID: <20200220135451.5f6f373f@gandalf.local.home>
In-Reply-To: <1581337151-11231-1-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1581337151-11231-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 13:19:11 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> This allows using parsing __print_hex_dump in user space tools. Print
> format is aligned with debugfs tracing interface.
> 
> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
> v2:
> Fix checkpatch warning
> Use is_power_of_2() function
> 
>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
