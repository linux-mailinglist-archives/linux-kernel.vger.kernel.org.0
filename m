Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDDD31599
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 21:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEaTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 15:49:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43152 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfEaTt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:49:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so10712775lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XJKszXT9nzmab/n0OLDhIOStZBWGsk7FbZlCagWz2Q=;
        b=fJc0fkmlN3PrvuO2sTLNlFimmBlSGtrm6X8n93j7QiUf3mTbBaoJQr7T/zjlJBSihF
         OFsuvdgNOTf63LLkk2Hv2QfXRI/ytz4gQmNu48KLfEJkcYYE5Gq5Z1Y9XLTYSKCLjGMu
         LyVgz2/ct6QMalCWwO6SL+2BGu2p3DVnwSO3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XJKszXT9nzmab/n0OLDhIOStZBWGsk7FbZlCagWz2Q=;
        b=SK/YnmsoJY7JpsQesP/31KU2RE84FmQbiLYSmBF2fJVbFyLpRA6sF3XPNXcQZEkkoO
         Mwhdd2Znv1YuFvYOL6pnGH892mp15mINH5cm4lIiCvOCB43p8DUYcMWLOJvOQR4aZVKr
         E7sCAaSm5SczHA1MYc6hcDjnwyV+UBSJK7hXB5EDcc1o7ctDLDV05GV/3yTM0noPi5sY
         3uIfOsSsyctrziou16f/eeRIcDrX9IughEnm+m3a77ai5SHpTqAksAmzqO7CQJgeQbqp
         nZfYxO0OC742rH+5IJfvDczLDlhjk/G7R7tgqidEp7VsW+qYMYFweCUR46mGc4jKUjNU
         i7lA==
X-Gm-Message-State: APjAAAXFIuNGF91RRYclWNm00x6v73o5asd/m/4v5isUAYqS7rlHuufm
        QbirxN+LJX+LvOvprmMhcPavlxwLdFs=
X-Google-Smtp-Source: APXvYqweYfvPPtiF8sexdFzTH9BvvbzZhklBIypkbn4X/ubzIiE53TOpO0XO+G/7ibqFbwpXeEZPwA==
X-Received: by 2002:a2e:9259:: with SMTP id v25mr4322500ljg.46.1559332165062;
        Fri, 31 May 2019 12:49:25 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id m63sm1402518lje.44.2019.05.31.12.49.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 12:49:24 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v29so889893ljv.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:49:23 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr7042553ljj.147.1559332163658;
 Fri, 31 May 2019 12:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135317.3c8d0d7b@lwn.net>
In-Reply-To: <20190530135317.3c8d0d7b@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 May 2019 12:49:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP3Ch2Lp-RzVZFsMRgzbVbY1ttVJQ-ds-gJcnpm3paag@mail.gmail.com>
Message-ID: <CAHk-=wjP3Ch2Lp-RzVZFsMRgzbVbY1ttVJQ-ds-gJcnpm3paag@mail.gmail.com>
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:53 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> This is a first attempt at following through on last month's discussion
> about common merging and rebasing errors.

Looks good to me,

                Linus
