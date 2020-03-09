Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5B17E0E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCINOM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Mar 2020 09:14:12 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33165 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCINOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:14:12 -0400
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0C204100007;
        Mon,  9 Mar 2020 13:14:04 +0000 (UTC)
Date:   Mon, 9 Mar 2020 14:14:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, frieder.schrempf@kontron.de,
        tglx@linutronix.de, stefan@agner.ch, juliensu@mxic.com.tw,
        allison@lohutok.net, linux-kernel@vger.kernel.org,
        bbrezillon@kernel.org, rfontana@redhat.com,
        linux-mtd@lists.infradead.org, yuehaibing@huawei.com,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v3 0/4] mtd: rawnand: Add support Macronix Block
 Portection & Deep Power Down mode
Message-ID: <20200309141403.241e773e@xps13>
In-Reply-To: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Tue,  3 Mar 2020 15:21:20
+0800:

> Hi,
> 
> Changelog
> 
> v3:
> patch nand_lock_area/nand_unlock_area.
> fixed kbuidtest robot warnings and reviewer's comments.

I know it is painful for the contributor but I really need more details
in the changelog. This is something I care about because I can speed-up
my reviews when I know what I already acked or not. "fixing reviewer's
comments" is way too vague, I have absolutely no idea of what I told
you last time :) So please, for the next iterations, be more verbose in
these changelogs! (that's fine for this one, I'll check myself).

Cheers,
Miquèl
