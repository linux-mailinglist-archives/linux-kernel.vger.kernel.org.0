Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC5C3E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfJAR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:27:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbfJAR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:27:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1D8F6154F3D76
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 10:27:38 -0700 (PDT)
Date:   Tue, 01 Oct 2019 10:27:37 -0700 (PDT)
Message-Id: <20191001.102737.269828508885775371.davem@davemloft.net>
To:     linux-kernel@vger.kernel.org
Subject: bad changes to object building recently
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Oct 2019 10:27:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know what has caused this but I am hitting two big problems
which are severely effecting my daily workflow:

1) Something is grinding like crazy when just building a single
   object like "make path/to/foo.o", it looks like make is churning
   on lots of work.

   This used to be instantaneous and is essential for my build sanity
   checking when I apply networking patches.

2) You no longer can do a "make path/to/foo.o" to force an object file
   to be built outside of your current config.  This is also essential
   for my workflow, I can force build objects only enable'able on
   other platforms and it works %95 of the time for basic build sanity
   checking.

Someone please track down these problems and fix them.

Thank you.
