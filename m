Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C405647A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFZIYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 04:24:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZIYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:24:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85C7EAD18;
        Wed, 26 Jun 2019 08:24:18 +0000 (UTC)
Message-ID: <1561536635.23604.8.camel@suse.com>
Subject: Re: [RFC] deadlock with flush_work() in UAS
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Tejun Heo <tj@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Wed, 26 Jun 2019 10:10:35 +0200
In-Reply-To: <Pine.LNX.4.44L0.1906241007350.1609-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1906241007350.1609-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 24.06.2019, 10:22 -0400 schrieb Alan Stern:
> But that pattern makes no sense; a driver would never use it.  The 
> driver would just do the reset itself.

Correct. But UAS and storage themselves still need to use
WQ_MEM_RECLAIM for their workqueues, don't they?

	Regards
		Oliver

