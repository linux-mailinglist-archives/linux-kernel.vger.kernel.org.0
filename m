Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E5DC8AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfJBOR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 10:17:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:46292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727708AbfJBOR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:17:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E62AAC7B;
        Wed,  2 Oct 2019 14:17:56 +0000 (UTC)
Message-ID: <1570025874.2472.14.camel@suse.com>
Subject: Re: [RFC PATCH 05/22] thunderbolt: Add helper macros to iterate
 over switch ports
From:   Oliver Neukum <oneukum@suse.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Date:   Wed, 02 Oct 2019 16:17:54 +0200
In-Reply-To: <20191001113830.13028-6-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
         <20191001113830.13028-6-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 01.10.2019, 14:38 +0300 schrieb Mika Westerberg:
> @@ -1975,10 +1972,8 @@ void tb_switch_suspend(struct tb_switch *sw)
>         if (err)
>                 return;
>  
> -       for (i = 1; i <= sw->config.max_port_number; i++) {
> -               if (tb_port_has_remote(&sw->ports[i]))
> -                       tb_switch_suspend(sw->ports[i].remote->sw);
> -       }
> +       tb_switch_for_each_remote_port(sw, i)
> +               tb_switch_suspend(sw->ports[i].remote->sw);

This macro looks a bit prone to misunderstanding.
I guess the function would be better if the test could be seen.

	Regards
		Oliver

