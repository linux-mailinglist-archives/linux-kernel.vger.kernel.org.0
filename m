Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01E9166763
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgBTTo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:44:57 -0500
Received: from muru.com ([72.249.23.125]:56484 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbgBTTo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:44:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1F44C8080;
        Thu, 20 Feb 2020 19:45:41 +0000 (UTC)
Date:   Thu, 20 Feb 2020 11:44:53 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] n_gsm: drop unneeded gsm_dlci->fifo field
Message-ID: <20200220194453.GT37466@atomide.com>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Jiri Slaby <jslaby@suse.cz> [700101 00:00]:
> gsm_dlci->fifo always points to gsm_dlci->_fifo. So drop the pointer and
> rename _fifo to fifo. And update all the users (add & to them).

I gave this series a quick test with my pending n_gsm serdev changes
and things work fine for me.

So for the whole series, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
