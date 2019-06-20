Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890214DAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfFTUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 16:09:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:47614 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfFTUJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:09:39 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 07FB72BA;
        Thu, 20 Jun 2019 20:09:38 +0000 (UTC)
Date:   Thu, 20 Jun 2019 14:09:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: stop suggesting strlcpy
Message-ID: <20190620140937.16c12e94@lwn.net>
In-Reply-To: <20190613162548.19792-1-steve@sk2.org>
References: <20190613162548.19792-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 18:25:48 +0200
Stephen Kitt <steve@sk2.org> wrote:

> Since strlcpy is deprecated, the documentation shouldn't suggest using
> it. This patch fixes the examples to use strscpy instead. It also uses
> sizeof instead of underlying constants as far as possible, to simplify
> future changes to the corresponding data structures.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied, thanks.

jon
