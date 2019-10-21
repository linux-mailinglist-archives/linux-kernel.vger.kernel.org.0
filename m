Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F749DF899
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 01:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfJUXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 19:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfJUXVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:21:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA9920882;
        Mon, 21 Oct 2019 23:21:49 +0000 (UTC)
Date:   Mon, 21 Oct 2019 19:21:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
Message-ID: <20191021192146.0d651ce2@oasis.local.home>
In-Reply-To: <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com>
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com>
        <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
        <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 13:41:51 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Mon, Sep 23, 2019 at 2:13 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Hi, Steven
> >
> > Any reviews for V3? I've addressed your concern about Kconfig.
> >  
> 
> Ping..

Sorry, I still haven't forgotten about you. Just trying to deal with
other fires at the moment.

-- Steve
