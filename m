Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A437814DE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 16:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgA3Pni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 10:43:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3Pni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:43:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0319FAFCC;
        Thu, 30 Jan 2020 15:43:37 +0000 (UTC)
Date:   Thu, 30 Jan 2020 07:33:28 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: relax unthrottle memory barrier
Message-ID: <20200130153328.jt5stb4svajrbkf6@linux-p48b>
References: <20200130100658.683-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200130100658.683-1-johan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020, Johan Hovold wrote:

>Commit a8d78d9f3856 ("USB: serial: clean up throttle handling")
>converted the throttle handling to use atomic bitops. This means that we
>can relax the smp_mb() in unthrottle() to smp_mb__after_atomic(), which
>for example is a no-op on architectures like x86 that provide fully
>ordered atomics.
>
>Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
