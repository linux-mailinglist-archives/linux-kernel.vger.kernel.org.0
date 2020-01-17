Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB431402ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 05:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgAQERC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 23:17:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40528 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgAQERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:17:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so21316427wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=k8/9CrxbLs3QhSIr5yxD/2JbyGuJlq96Zeu+NfPwzOg=;
        b=nDvs29haeo+oohT6+WxzfapKHGhinsl+mS2lTOX65kaM7va5Gp6M3nDobQ4+aK6U6t
         IBdOx24p08Cu+Zt2U7+GeSlk0voXRoljO1va3xpwaisienm2nDuAxMi4+uUddiKN6jn+
         vmzuGb88wl1hHIk/LrOJmLaAAIb8ePs1BFobXvJZWn4kFefZ95rpZ4UQM1Dk3q82F9qJ
         O+3HGkU2bgd5vYF1nqoWmhnCQxEWmsJX6Koz2QihJoSq925/I1iz49bUK0D8+pk/y6sl
         b4mY3UbH/3K7Ug+du0sqLBm/zvYwMoNMIIm73tRXiVBa3N82ACzH0SSE9w4anv7akzrC
         R0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=k8/9CrxbLs3QhSIr5yxD/2JbyGuJlq96Zeu+NfPwzOg=;
        b=t5kzMjyRc0zGObKg2BuR7HtRkk8INZ2G8/knHxeEBep4TLwlBwOqjRd5gguB/gg8b8
         NNlk4cvKhgqtQYTAIFM6cWGg/MyEKwP+8BDYzbzP+KWvqVBEKBTpyrvVkjHp0W/gD53h
         e7mmBvNSTOAPOgh1PrgQpIg1TSZWqUGT/jUY3uuhUuXKVfOjxGLBJ5pbMXO5RT/20Yce
         wwC1PgN9BZeX03zfYI/DOgEF/je9ZXcj15JvGO43vL4NXL8QWLPPuHx2STZpeYud4u7g
         Nt9imCVOp7qwe97gnvqbKLR74i6uFaDwSaC98sEVQoQdC3vLQ6AFn+Vtkmbe8FbXItg8
         2CuQ==
X-Gm-Message-State: APjAAAWDkRTUx6bOEfdZv5WhfSimCtZeifrIsMmrWETP/T6Sz53Wfrv4
        AjV47Ph1ddr0NfWo5jHISZGCnw4fO3p8ZQmXE/AZD9SB
X-Google-Smtp-Source: APXvYqwVP/JyDluOohxnbeNQ+BBMNy0AGf46wC3CoXLhAjlHAnHVmbB4a/9XNGAROoIswO9lxEmZPfiaX27BLt0/Gis=
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr825520wrs.179.1579234619235;
 Thu, 16 Jan 2020 20:16:59 -0800 (PST)
MIME-Version: 1.0
References: <CAAJw_ZsrUP54N5Ko2PrZm2BnKbxv44pXL3Ycw1Ux2onAFqrOVQ@mail.gmail.com>
In-Reply-To: <CAAJw_ZsrUP54N5Ko2PrZm2BnKbxv44pXL3Ycw1Ux2onAFqrOVQ@mail.gmail.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Fri, 17 Jan 2020 12:16:37 +0800
Message-ID: <CAAJw_ZsQkjdPo7McQoEb9LqBb0hzrzFRE4K_CR5dVApoT2_zmQ@mail.gmail.com>
Subject: Re: No realtime clock (/dev/rtc) on new ThinkPad X1
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:46 AM Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> Got installed Linux 5.5.0-rc6 on ThinkPad X1. CPU is i7-10510U (Comet
> Lake) ... and /dev/rtc is missing.
>
> Linux is latest git pull (f4353c3e2aaf7f7d3c5a18271b368bf5292854c3)
> CPU model name      : Intel(R) Core(TM) i7-10510U CPU @ 1.80GHz
>
> Am I missing something?

I can confirm that the same kernel works on another ThinkPad (tried on
P53 with i7-9750H) but not on X1.

Jeff.
