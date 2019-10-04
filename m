Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF5CC4E1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 23:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfJDVi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 17:38:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43610 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:38:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so7877159ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRAc62gXtPBKRS38xYdigbDwlITW2b4WE0eT5kkYxq8=;
        b=MO1o1GKZKe0wHXwuXT1J6brobS8MLc1iJ57iKwIs/hF317Z/7cQXPXf/ZOZTQnhyac
         bpZ9LLIE7ndE5MG4snTxWYZCa7uyxqWNiwD72CZG2l+oCHbo70K2kyTaB/kASxIsdUIo
         pignYGI7vksf894FIhQUunwDnaoMZNLFA05n0NGdHlJzasAuVTS4L+40RHiltmLQxhJa
         0zbh7L9oItbK6G2NjV6888RSLghmQcMNhJem1cnTRr8djiHtQ/01LVvlYmOhViEC3Aer
         3ZMtpKSbSBSEo8WJBTBkZhr6pt73NyshdSURD5I8gOa/ac4PUR4X/NsCHMMwRgcpiDjp
         Pz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRAc62gXtPBKRS38xYdigbDwlITW2b4WE0eT5kkYxq8=;
        b=jGw51sXSB1gQcHtTQIgbF8gikO0wWcdM7kjIrfwCjq0py5BoOgex6llJzAYEpw+LKH
         GEcLZNxwTiiU7vWJJmhcLu/AyA0sevnZkUzJw+LI2TorYTOlTGv0A/njf5QI/e1GwHsz
         fJzLAjn1US99xaFcc/C9ZCg/j4n0hJTVQl8KQdEVurhZ+sHqDAwSYs7k811nFFxmLIT2
         Fjza5a3TbdIrh73N2G46kAkJrUjqu9rhWXE9BHyr1ZpyrelVM00yqo+49ZVOSgMXX2wi
         8+cB9CpNm+LTfWOmn4KTfq3N+7bVXpJLKIXM0v4YpCpdwSLGyeK3t5JLPSdx7+yMLmds
         xxMg==
X-Gm-Message-State: APjAAAVHnzQssFJhPRiueviYB/i48zbay07iLE8pfyr3XSPg8tk0l3D8
        tzGzb6Q3QKWZsQ+wHp8dOjhubn084Un27cpOJO0izw==
X-Google-Smtp-Source: APXvYqwVqa3ntHGFTJZakMoLSi/yRzk3PWsVbI/cLCjoEnPNVFZGy9RtSFmcdpmUA1Y9q+WNK2/Mv8JK1l9BXaYiT7I=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr10670560ljk.152.1570225103606;
 Fri, 04 Oct 2019 14:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569572448.git.baolin.wang@linaro.org> <a6b18f17b995bceaf2fc0129866301dd8f46bee4.1569572448.git.baolin.wang@linaro.org>
In-Reply-To: <a6b18f17b995bceaf2fc0129866301dd8f46bee4.1569572448.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:38:12 +0200
Message-ID: <CACRpkdYF3hPit5EgWCXuM1exoWMFn_7k=OyM99ojS9WeJeMRFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwspinlock: u8500_hsem: Use devm_hwspin_lock_register()
 to register hwlock controller
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:28 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Use devm_hwspin_lock_register() to register the hwlock controller instead of
> unregistering the hwlock controller explicitly when removing the device.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
