Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2E3512233B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 05:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLQEpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 23:45:53 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35821 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLQEpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:45:53 -0500
Received: by mail-pl1-f181.google.com with SMTP id g6so2879303plt.2;
        Mon, 16 Dec 2019 20:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9KPJpeAb0RjAXPPfNOtoDwhhw3DIxIuTplIClbJ1Lgo=;
        b=o8W1XlKk4iYzwerNhod61tyTizzkxHZy9faPyrnjBHL86pDG0k3AmPCm4rzovw8Gmh
         ZYxBd386Ryrw2k3h2YrC8GR31qlxGEjlTUU5roI2+WmSqWOWLL4QoJeRxwGxMp7a0G+/
         1yaXkP2f13Q0hQ4c2tCq51fDbFjINo5PloNDVs2eNjynvaPYd4xe9Ot7ks6p8TZwbXcJ
         uxdAnZB1HzBYILP1xr+SgnLEmiu34Ch0WsokV5+a8uhZiK4tKYXyZPniaXGlUBG7+oVg
         /A01e/zpT0mwAaEcYBFGK6VjVq2s+nJ6QGMycZfbNnXwEjRoRCQp5oTQ6EMnVMyX6oik
         zSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KPJpeAb0RjAXPPfNOtoDwhhw3DIxIuTplIClbJ1Lgo=;
        b=DTt5nAk2hIqbbl1GpwtX0rfvQJSXYNmH8YIlxYA+wYS418UEPSceKByqPL002ZRoD/
         xRsa+qceeCtPb2KOtHDMNg31TjOgui//jOtInw6J/5x1oNwpVkcGVqr1mb/u9zTaD6JJ
         gft9wDwhoBkcRemd+nlqq1xeCv3TeA5rTAPUCNLXzn5wD8XiVCy7A9PU20/W2J3COJ6v
         pbPQjyMKqlPQcGpxlSLDvssh5p0vzz+GH36V3gqHuiARP/orspuL7iBmjq/4LCMCbKmo
         oSYW+NtgsFgt4LLIjVLnl1xoAyVXCESJcT4l0/Iu1feAAUFrDC9WmtGeDeKATskTJrKk
         raKw==
X-Gm-Message-State: APjAAAXrk1N4Mx5gV/PzOEwQVP5mYeVj4SYisiZjoF5Kf+tMPNPpo4mF
        lYaumj+LzX9X1kEl9OVNwrjNQVHw
X-Google-Smtp-Source: APXvYqwjv+rG89lnfzecThTBffSmvDQCK+Lhix3ZbirGMxUbOD2ASmp7bX5kZJJvApBPLgkUVdsLTg==
X-Received: by 2002:a17:90a:974a:: with SMTP id i10mr3870722pjw.0.1576557952746;
        Mon, 16 Dec 2019 20:45:52 -0800 (PST)
Received: from localhost (c-73-241-114-122.hsd1.ca.comcast.net. [73.241.114.122])
        by smtp.gmail.com with ESMTPSA id f23sm24121540pgj.76.2019.12.16.20.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 20:45:51 -0800 (PST)
Date:   Mon, 16 Dec 2019 20:45:49 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.21-rt15
Message-ID: <20191217044549.GB1363@localhost>
References: <20191216173416.2dcmfis4xza2dqf5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216173416.2dcmfis4xza2dqf5@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:34:16PM +0100, Sebastian Andrzej Siewior wrote:
> 
>   - Since the migrate_disable() rework, with heave changing of the
>     task's affinity mask the kernel could issue a warning in
>     migrate_enable() and crash later.

What is "heave changing?"

Just Curious,

Richard
