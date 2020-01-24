Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0F1476AA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 02:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgAXBXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 20:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgAXBXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:23:22 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF94207FF;
        Fri, 24 Jan 2020 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579829002;
        bh=08cTEu9ASs53hJjSSTAEYpZBVzWdSRM6CeG1YjlGUz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cloRRdkkcIuenl6ECOeuogMUGj3Z2GxhDnn4EoZvXu16OBGU3R+BZjFbCu2w+HOri
         JHw7AxqMvYYlCfK5OfcSaAH6ZZbDh7xzVQEawNmDlN4yB9+AJSuXNPmW6CdYEID5zG
         +ee+QE8CF3IZg4nsO1bcvAeGND1q4HdKWGThrmEE=
Date:   Thu, 23 Jan 2020 17:23:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     gregkh@linuxfoundation.org, jannh@google.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] kernel/relay.c: fix read_pos error when multiple
 readers
Message-Id: <20200123172321.0ef6744e784692585f9843b3@linux-foundation.org>
In-Reply-To: <1579691175-28949-1-git-send-email-yangpc@wangsu.com>
References: <1579691175-28949-1-git-send-email-yangpc@wangsu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 19:06:15 +0800 Pengcheng Yang <yangpc@wangsu.com> wrote:

> When reading, read_pos should start with bytes_consumed,
> not file->f_pos. Because when there is more than one reader,
> the read_pos corresponding to file->f_pos may have been consumed,
> which will cause the data that has been consumed to be read
> and the bytes_consumed update error.

That sounds fairly serious.  Are you able to describe a userspace setup
which will trigger this?  Do you have any test code which is able to
demonstrate the bug?

We really should have a relay testcase in tools/testing, but relay came
along before we became diligent about this.

