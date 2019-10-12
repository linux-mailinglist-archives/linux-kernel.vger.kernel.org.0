Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36964D4BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 03:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfJLBfD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Oct 2019 21:35:03 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:39016 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLBfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 21:35:02 -0400
Received: by mail-qt1-f175.google.com with SMTP id n7so16573794qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 18:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p6CkBjyXyubfrdK0PtyVtXiNsy98CJHwCPycTQri2gQ=;
        b=jPKlWv2QYfhgWjC55ITC00EP7oo5mBIU4oKZ9+bqpkRe0wUd3axFVZ8dyLNe6YLhoa
         eOdOHk1tNB6XyyEbAGqCA29vSDgHztfeYI2T6H0s8VPx0f4FjH5gz4fShwoDxrnGyK22
         3dlY8eZ2Y9HNXF8gjHRl3wILWEYu9CgQWMYWMO7I+EdfBPtXOUXFwS/Byoqg6qtjrknv
         QXlZYfjbPriDWEsxUMsI3tfH6s1wczoUFu30X7Wql2BK6hyStgdL6ueA56l0yv43gAuZ
         Gt9EGru/Lh4EEpQnbPeW9Z1vTp01K1j7Ay1Mw07CS7IBJ5+P+FZPNOzmUqIeeUroAsV2
         MvDA==
X-Gm-Message-State: APjAAAVSBikhDgZdichAi9AqPBO1J4vAm3wLcpsnnMRtbFqses9xzPqn
        SN27mZEDX/Fes8coZ+7ghC+QcyfBAwRdEcnn1SoS909R
X-Google-Smtp-Source: APXvYqze61CDPjfI06KRRKGyWbEzD9XW9xPGC20GXfN0zTKReI/D3BO4vWpn8dKwu+8ib2T0ri4uQoaI++OfyEtlDgE=
X-Received: by 2002:a05:6214:1226:: with SMTP id p6mr19198520qvv.167.1570844101667;
 Fri, 11 Oct 2019 18:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <79BF3B6A-6533-48C7-BD4D-8D64FC2B397A@flygoat.com>
In-Reply-To: <79BF3B6A-6533-48C7-BD4D-8D64FC2B397A@flygoat.com>
From:   Konstantin Ryabitsev <mricon@kernel.org>
Date:   Fri, 11 Oct 2019 21:34:50 -0400
Message-ID: <CAMwyc-TDssA+uFKWi+9VU8cpYvLf1AHZow7Dib+naYc2QnernQ@mail.gmail.com>
Subject: Re: Kernel.org SSL certification expired
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Konstantin Ryabitsev <mricon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 at 21:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Hi kernel.org sysadmin team,
>
> It seems like SSL certification of kernel.org is expired today. With HSTS enable, we can't reach kernel.org now.

The APAC frontends were still serving the old certificate because the
cert renewal process failed to restart the daemon. It should be good
now for everyone.

Regards,
-- 
Konstantin Ryabitsev
Kernel.org Systems Administrator
Montéal, Québec
