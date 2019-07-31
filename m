Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48AE27CC74
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 21:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfGaTGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 15:06:03 -0400
Received: from ms.lwn.net ([45.79.88.28]:55684 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaTGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:06:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 435806D9;
        Wed, 31 Jul 2019 19:06:02 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:06:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: email-clients miscellaneous fixes
Message-ID: <20190731130601.1859be1f@lwn.net>
In-Reply-To: <20190706210100.26698-1-federico.vaga@vaga.pv.it>
References: <20190706210100.26698-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Jul 2019 23:01:00 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Fixed some style inconsistencies and remove old statement referring to
> kmail missing feature (saving email from the view window is possible).
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

So this one fell through the cracks, it seems, sorry.  Applied now.

Thanks,

jon
