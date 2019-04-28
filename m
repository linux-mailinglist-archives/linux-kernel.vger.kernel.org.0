Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A65D999
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 00:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfD1WtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 18:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfD1WtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0FAAAE16;
        Sun, 28 Apr 2019 22:49:10 +0000 (UTC)
Date:   Mon, 29 Apr 2019 00:49:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/oom_killer: Add task UID to info message on an oom
 kill
Message-ID: <20190428224907.GC956@dhcp22.suse.cz>
References: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-04-19 14:20:13, Joel Savitz wrote:
> In the event of an oom kill, useful information about the killed
> process is printed to dmesg. Users, especially system administrators,
> will find it useful to immediately see the UID of the process.
> 
> In the following example, abuse_the_ram is the name of a program
> that attempts to iteratively allocate all available memory until it is
> stopped by force.

There was a more general rework of this message
http://lkml.kernel.org/r/1542799799-36184-1-git-send-email-ufo19890607@gmail.com
but I do not see it merged into Andrew's tree. Could you have a look and
pursue it, please?

-- 
Michal Hocko
SUSE Labs
