Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA70BC3A76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbfJAQ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:27:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfJAQ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:27:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33E36AF27;
        Tue,  1 Oct 2019 16:27:57 +0000 (UTC)
Message-ID: <1569947262.2639.15.camel@suse.com>
Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
From:   Oliver Neukum <oneukum@suse.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Date:   Tue, 01 Oct 2019 18:27:42 +0200
In-Reply-To: <20191001150734.GA2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
         <20191001113830.13028-18-mika.westerberg@linux.intel.com>
         <20191001124748.GH2954373@kroah.com>
         <20191001130905.GO2714@lahna.fi.intel.com>
         <20191001145354.GA3366714@kroah.com>
         <20191001150734.GA2714@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 01.10.2019, 18:07 +0300 schrieb Mika Westerberg:

Hi,

> OK, but does that break existing .configs? I mean if you have already
> CONFIG_THUNDERBOLT in your .config/defconfig does it now just get
> dropped silently?

People will have to look at this new stuff anyway.

> For example firewire has CONFIG_FIREWIRE even though the "standard" name
> is IEEE 1394. I was thinking maybe we can do the same for
> USB4/Thunderbolt

USB and Thunderbolt used to be distinct protocols. Whereas Firewire
was just a colloquial name for IEEE1394. Please be wordy here.
"Unified support for USB4 and Thunderbolt4"

	Regards
		Oliver

