Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305057CC94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfGaTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 15:14:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:55752 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbfGaTOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:14:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF9CA6D9;
        Wed, 31 Jul 2019 19:14:08 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:14:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     mathieu.poirier@linaro.org, mchehab@kernel.org, leo.yan@linaro.org,
        marc.w.gonzalez@free.fr, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        suzuki.poulose@arm.com
Subject: Re: [PATCH] Documentation: coresight: convert txt to rst
Message-ID: <20190731131407.345e5935@lwn.net>
In-Reply-To: <20190711165201.31798-1-tranmanphong@gmail.com>
References: <20190705204512.15444-1-tranmanphong@gmail.com>
        <20190711165201.31798-1-tranmanphong@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019 23:52:01 +0700
Phong Tran <tranmanphong@gmail.com> wrote:

> This changes from plain text to reStructuredText as suggestion
> in doc-guide [1]
> 
> [1] https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html
> 
> Some adaptations such as: literal block, ``inline literal`` and
> alignment text,...
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Applied at long last, sorry for the delay.

Thanks,

jon
