Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1FE1C769
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 13:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfENLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 07:02:37 -0400
Received: from torres.zugschlus.de ([85.214.131.164]:51822 "EHLO
        torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENLCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:02:36 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.92)
        (envelope-from <mh+linux-kernel@zugschlus.de>)
        id 1hQVCc-0003cS-Tg
        for linux-kernel@vger.kernel.org; Tue, 14 May 2019 13:02:34 +0200
Date:   Tue, 14 May 2019 13:02:34 +0200
From:   Marc Haber <mh+linux-kernel@zugschlus.de>
To:     linux-kernel@vger.kernel.org
Subject: Re: Linux 5.1 on APU runs in circles with Call Traces
Message-ID: <20190514110234.GB1402@torres.zugschlus.de>
References: <20190512193203.GA1402@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190512193203.GA1402@torres.zugschlus.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 09:32:03PM +0200, Marc Haber wrote:
> I regret to inform you that I have now the third crippling issue in
> Linux 5.1, with the fourth one in the process of being isolated.

I had GPIOLIB missing in my kernel configuration. That was not
autodetected and resulted just in a bunch of kernel warnings scrolling
by in a second. make oldconfig allowed me to actually see the
warnings. Issue solved.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
