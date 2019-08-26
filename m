Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1209D2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfHZPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 11:31:34 -0400
Received: from muru.com ([72.249.23.125]:58674 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfHZPbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:31:33 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 02D3780AA;
        Mon, 26 Aug 2019 15:32:02 +0000 (UTC)
Date:   Mon, 26 Aug 2019 08:31:30 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] bus: ti-sysc: Change return types of functions
Message-ID: <20190826153130.GV52127@atomide.com>
References: <20190813114256.GR52127@atomide.com>
 <20190815054647.32750-1-nishkadg.linux@gmail.com>
 <cb5483e4-ddec-497c-6355-56d557ad6ca1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5483e4-ddec-497c-6355-56d557ad6ca1@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190815 13:03]:
> On 15/08/2019 08:46, Nishka Dasgupta wrote:
> > Change return type of functions sysc_check_one_child() and
> > sysc_check_children() from int to void as neither ever returns an error.
> > Modify call sites of both functions accordingly.
> > 
> > Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Applying into omap-for-v5.4/ti-sysc thanks.

Tony
