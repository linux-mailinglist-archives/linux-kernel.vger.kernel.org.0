Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EF0B4B77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 12:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfIQKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 06:03:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfIQKD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:03:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68372B634;
        Tue, 17 Sep 2019 10:03:55 +0000 (UTC)
Date:   Tue, 17 Sep 2019 12:03:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: threads-max observe limits
Message-ID: <20190917100350.GB1872@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just stmbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
observe limits") and I am really wondering what is the motivation behind
the patch. We've had a customer noticing the threads_max autoscaling
differences btween 3.12 and 4.4 kernels and wanted to override the auto
tuning from the userspace, just to find out that this is not possible.

Why do we override user admin like that? I find it quite dubious to be
honest. Especially when the auto-tunning is just a very rough estimation
and it seems quite arbitrary.

Thanks
-- 
Michal Hocko
SUSE Labs
