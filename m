Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1917C7CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 16:24:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39960 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:24:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id p5so3037319lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjyPpVTg5zBLZB9dkLlfI0p3PLTjhWDlILz7pqVVH5k=;
        b=diQmQ6Xcr3yEfN1nPRo2OpPy8etOnLcQLhOojFCMplJAtgGWwLj+wr+YOQtcBpnn7+
         dhl/5Tvv/R1Jdhgp8OwzGidPP4Ohuqvvs4Al+z/82HJThwUfR8RgppG8gwyJJCQ1bHO1
         /3zh5jkFhyCuTH7JFJmLrl+fl1rmmwQGyfL2wPx2TwgNoeVJFGTI21ZW1ehssoG/PeUD
         FQy5g9Dbjy53oUWa3CFjsK6yEdQxk/BjA8XoNwt2O9MrV79C2ut8H7AsH1v/ckksc5WE
         LzGiWsyJUqI6uDBhG2Tf95l9T2OCt2B8WC2/uFwuy03DYeTCGiR9qmk3uMKTY+A5QPR6
         uDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjyPpVTg5zBLZB9dkLlfI0p3PLTjhWDlILz7pqVVH5k=;
        b=BvjoBm1XEU44Tln8dVX915Ymu/XjmtO8qzQt0DjLRm5eGm9/yWQz5143wDwaY8qV1Q
         LT2W+3LOhFvrNbzmd+c6z+Z0Ljjdw+tA77dYwbq94gV+V2MUgPRWLGRHCJ8r17BTZKXL
         ZAd+lsSCN//mkzcvgr5N5AG+h3vUOL897PA8J9PI2KKmI9rKRIPFTarefp8fJ2+vDgn5
         CZ1/DHhckVLHIJqemWQvfeyi7Qk1EzxJX/Vm2IWcoPLn3rFuc4XKiCYssWY3jG8bnE2q
         u6WsMdC3NmWgbh/Jh3kcFvirdl/UG/3rOqeyfbJi72lfvfCQ/7Sr6UoDZt6W4Jgp4Dsm
         HFTQ==
X-Gm-Message-State: ANhLgQ1BE3Q8mVlcnGziz6N/E6kI7iaol/kN/nxDxaQJ45qBS/ze13pj
        cEuXhin3d6EkQIO9ReLcRacz8hXOqcLbY+jJEq/0Sw==
X-Google-Smtp-Source: ADFU+vvbSInXehXUeU32bhCo+qWpn7pq92iIMxLGeDe9WJadnAzcbybo67yrbVWFBBf9omL4H9Vr3FmvjPK6B5of4yQ=
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr2938013lfd.74.1583529889772;
 Fri, 06 Mar 2020 13:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20200212195231.GA2867@embeddedor> <CANiq72nt19x2Z6ErT8a1_2c0sKfjkv_yUFMZS2mf3HWp3RvnDQ@mail.gmail.com>
 <0dd75019-4d02-24ee-fdf1-f713a99d4141@embeddedor.com>
In-Reply-To: <0dd75019-4d02-24ee-fdf1-f713a99d4141@embeddedor.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Mar 2020 22:24:38 +0100
Message-ID: <CANiq72nWDHV3z9kemqjKuVwsSN0XxJvgvngVu+V1y2d54V6obQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Thu, Feb 13, 2020 at 7:11 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Please, go ahead and handle it.

Picking it up for next week!

Cheers,
Miguel
