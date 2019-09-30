Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338E6C2116
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfI3NCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 09:02:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730830AbfI3NCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:02:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FBC8AF2B;
        Mon, 30 Sep 2019 13:02:08 +0000 (UTC)
Message-ID: <1569847603.2639.0.camel@suse.com>
Subject: Re: 4f5368b5541a902f6596558b05f5c21a9770dd32 causes regression
From:   Oliver Neukum <oneukum@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Stefan Dirsch <sndirsch@suse.com>,
        Thomas Zimmermann <tzimmermann@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 30 Sep 2019 14:46:43 +0200
In-Reply-To: <CAKMK7uHicakgeTEUhK63R4yKh+HMHCmy11L_o5PCSJoLG65BYg@mail.gmail.com>
References: <1569439345.3084.5.camel@suse.com>
         <CAKMK7uHicakgeTEUhK63R4yKh+HMHCmy11L_o5PCSJoLG65BYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 25.09.2019, 21:48 +0200 schrieb Daniel Vetter:
> which undoes any side-effect of the patch you're pointing at. I am
> rather surprised though that this results in a hard-lookup for you,
> did you confirm the bisect by reverting that commit on top of latest
> upstream?

Hi,

yes, a straight revert fixes the issue.

	Regards
		Oliver

