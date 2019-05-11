Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C451A9BF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 00:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEKWzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 18:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfEKWzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:55:02 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A90B20989;
        Sat, 11 May 2019 22:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557615301;
        bh=/k/9Cg6VtO5vjMH0ai8HqGtQORppVHKXJq9XUukPoIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=caog7YeaYk9txZvrET1Nqkv/8rv0clJ+/2jMhUsS7dxJLfAulOQNX1yASEyVDfguD
         7dTvGXRL8VhZr38yiCo+zkKbO5dtfNKVYJy6XzNdkALmmv2poWir3xPLlQxZTeAXUc
         vEB++Y1OXs8PHtodlkINv9N6HYd5F+v33pd40IEU=
Date:   Sat, 11 May 2019 15:55:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Timmy Li <scuttimmy@gmail.com>
Cc:     ebiederm@xmission.com, mhocko@suse.com, willy@infradead.org,
        oleg@redhat.com, rppt@linux.vnet.ibm.com,
        ktsanaktsidis@zendesk.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Remove unneeded hash header file
Message-Id: <20190511155500.52ff546b6c6443295937c0f9@linux-foundation.org>
In-Reply-To: <20190430053319.95913-1-scuttimmy@gmail.com>
References: <20190430053319.95913-1-scuttimmy@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 22:33:19 -0700 Timmy Li <scuttimmy@gmail.com> wrote:

> Hash functions are not needed since idr is used now.
> Let's remove hash header file for cleanup.
> 

OK.

And the nice block comment at the start of kernel/pid.c is rather out
of date...

