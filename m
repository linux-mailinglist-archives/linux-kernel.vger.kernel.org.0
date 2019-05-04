Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE213BF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 21:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfEDTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 15:25:12 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7749 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbfEDTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 15:25:12 -0400
X-IronPort-AV: E=Sophos;i="5.60,430,1549926000"; 
   d="scan'208";a="381667713"
Received: from abo-60-75-68.mrs.modulonet.fr (HELO hadrien) ([85.68.75.60])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 May 2019 21:25:10 +0200
Date:   Sat, 4 May 2019 21:25:10 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Vatsala Narang <vatsalanarang@gmail.com>
cc:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] staging: rtl8723bs: core: Remove return in void
 function.
In-Reply-To: <20190504184358.25632-1-vatsalanarang@gmail.com>
Message-ID: <alpine.DEB.2.21.1905042124130.2506@hadrien>
References: <20190504184358.25632-1-vatsalanarang@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -5828,8 +5822,6 @@ void survey_timer_hdl(struct timer_list *t)
>
>
>  exit_survey_timer_hdl:
> -
> -	return;
>  }

Are you sure that you compiled this code?  I'm not sure that it is possible
to have a label without a subsequent statement.

julia
