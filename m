Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559D1185749
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 02:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCOBgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 21:36:00 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:44544 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCOBf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:35:58 -0400
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id ABFFB200B3C;
        Sat, 14 Mar 2020 13:46:02 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id B294320821; Sat, 14 Mar 2020 14:36:32 +0100 (CET)
Date:   Sat, 14 Mar 2020 14:36:32 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Use scnprintf() for avoiding potential buffer
 overflow
Message-ID: <20200314133632.GB453554@light.dominikbrodowski.net>
References: <20200311090426.20161-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311090426.20161-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:04:26AM +0100, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied to pcmcia-next.

Thanks,
	Dominik
