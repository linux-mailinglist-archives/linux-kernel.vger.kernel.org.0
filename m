Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32F818574F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 02:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCOBgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 21:36:14 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:44552 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgCOBgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:36:00 -0400
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B82A7200B3E;
        Sat, 14 Mar 2020 13:46:02 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 19CBC2075D; Sat, 14 Mar 2020 14:36:19 +0100 (CET)
Date:   Sat, 14 Mar 2020 14:36:18 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: omap: remove useless cast for driver.name
Message-ID: <20200314133618.GA453554@light.dominikbrodowski.net>
References: <1582056436-15775-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582056436-15775-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:07:16PM +0000, Corentin Labbe wrote:
> device_driver name is const char pointer, so it not useful to cast
> driver_name (which is already const char).
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to pmcia-next.

Thanks,
	Dominik
