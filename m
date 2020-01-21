Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381AD143921
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAUJJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:09:02 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:09:02 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MkIAB-1jMWMn1ljF-00kjVj for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 10:09:00 +0100
Received: by mail-qv1-f46.google.com with SMTP id o18so1118231qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:09:00 -0800 (PST)
X-Gm-Message-State: APjAAAUi4SNy6DvjuHL6XZubUjRrU9ojWgzzD1QgUF0XwT9rIZAxxYPm
        PM4dGp+pCuALUSfmefTJ/IWesmnoU9jv9tssH5U=
X-Google-Smtp-Source: APXvYqy0lqLxIxKvl4NzSCuQ5JILGaII7vvEzP5ZVNMUF7o0+IiDeTWAI19y5yRZ2g/sjt5GRimbrfWLUPYCIocsAow=
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr3888671qvb.4.1579597739397;
 Tue, 21 Jan 2020 01:08:59 -0800 (PST)
MIME-Version: 1.0
References: <1579596524-257369-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1579596524-257369-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 10:08:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0kPaxs9PQM87mRtBbA5jn0v2PV8S4cntXZeXN_Xex3mA@mail.gmail.com>
Message-ID: <CAK8P3a0kPaxs9PQM87mRtBbA5jn0v2PV8S4cntXZeXN_Xex3mA@mail.gmail.com>
Subject: Re: [PATCH] agp/via: remove unused current_size
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1Qk2uXiW7mIFjDZk/b4aGnySQsDRipW2VVpsATVNIM+BSqomgZa
 a4F1ODMhn83fL71Tu8KodJjkZC7HgmPXt3oiYWfbdW2wymibNXOn0KYgLumYo0Nh1KfKhpU
 7371ZVnEBdQ/TcDYIlLkZGT+EKYdhaEHf6I7pE0BclPA9wtuI2qqI+Lv7adj338W23pN85z
 n671MdsWDARZLzUnFzU9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sS6wAaj3Hh0=:TZ8bvlSbNq4daPBUk/Pcj8
 6/2hx4YokLNwIKgpaeYAIYvE9ma025fi0aiCxLsfad7wnBol/3HYE5Otsw4xdW0HUB62O9q3U
 Qymxhrl56W0C5kQYCt53cghjvfqTCEd/e8N/B7CFH3Pq5DToQ4oRnwbwTrXvWpRO2HP+GGAUs
 4gh51w3WWImL7WELSKtxOjdmszb8sJMgd1yXhFbD54Ob7dHhu2odAwbQtIl9avCsdXsBGf7Gs
 ozFvgRS143PMF5+wUEcK1wE6y06/iG5FVhffruspjZ2/IaCrq9SeMMc7WSxNJkE9zr+WMsQPI
 mbNmuVvV3mVWjCzLvleWjXYS905yASAjYwqHrRHpvbSssI6WX5uHft+fpMnO1hElIe604dXhx
 mQLiQMBG7uhLjy/VkLXMDP6XSLt59pyyeq2zA22RPoRTm3Zv2Amsk/KaBjzuTnsKTjTdp2FOH
 Ja65wv+Dy2VqCMBvlA43DkBsANa3+cY3BLDBZALoLS5BQnl70OB+eD9qXyNxZcnX8pjRhcaNW
 y2LwF4F7xP9+nnTNj0L4XQ4Qejc7/UmNMAehAHRn5WoHPkPcZMzYAmZS9j6TMEotEh80V60J2
 Lqpuqt5l6ytT8mhUkwj71RlxAZlX6XwaVfzLfCIxU5nM9O62wRiVv/vet/CQYPBytTjgcnOTR
 /ClJtShok86aF2JbyNWVKsnQYryP5SCAirkeUKZWLtL4BDc1gulz9opzvLuOKVIqt7sV7MNgZ
 Nda/pKTk9CqzUTDXAUo7LQ0DnI0LQdiYHzAuLnkO8WmfxDb+fUH49KucU/FwsTj6S5ShNppA7
 WTyTr6+hgjVIw2exu9WgSAm4L28/0FpDt9lBbv8yvyI8ikY+kd/OkAADpWnqTQ1vzCt6o8xKx
 pq0MJVMT5zxdO7/c8MJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 9:48 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> No one care the current_size, so don't bother to get current_size.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
