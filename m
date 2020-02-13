Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436A815CAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBMSwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 13:52:14 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39001 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgBMSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:52:14 -0500
Received: by mail-pg1-f174.google.com with SMTP id j15so3586040pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fhZFg8LTdvZwHsW3ZofVRs07iAKz9GzQpl7hqklnVdo=;
        b=WD21nl2sCcyIyrvgV7IH4R5vJGA2IezVE9insgrlrYtwiNwhFoils+MnT6eM7kNs4g
         5bDAVtzY33TE2Dl53s/TJQ/S/OhkzPA7Jv9TZ5heQNjFAqm6GZ0Kr0DjD2E2HVxWWYm0
         gEoJ6AVwbo0WPeXyKCqfzpJjcxnwCh957sAJXEd8Fn0CSWuw8n1MK+yWqu9/7ZCLzSb1
         zdH2LZFJonFyPh2qAojMqCjobhEJmOZMGitftTsiugvQGrfLfA/bJ8jQoaKLxdbe6fb6
         5qjb01IdzxQ432NzQ8rRIvIWqTZ2w93o0EshP58ftGjurROeYbW9OxocBraqziIE3qg2
         W3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fhZFg8LTdvZwHsW3ZofVRs07iAKz9GzQpl7hqklnVdo=;
        b=et0JV2ydmZrANgj1u7CJR7e4irPr0z0kx4Bszop5PNaFVGeTpq8yo8dGCuiD8fNNxS
         bQxUGe0exqmc1DQVDX96xTuGKtSra9LCywhUFryAljBfsiCoHKiDAGAIiWC3ExMFX+o3
         5bx7tZOdbpcAa7WQFHTWb0Y/RAPpwUa0oy2hiC8Rq7FdghquEo+uH1XOqV6byl8U347R
         vivR4ULrXiPmwYvznt09rWSS+yH3nEefPlfjVzZEkDBikXbbZ2GPDeepK57EdoYZy6ab
         JNO030ck8FnCUBEuU/+04u6SWMPbPGNcoIDTGcv+jNF20f6HgPJdEQaqhPiR5Uryq+RG
         Jk6A==
X-Gm-Message-State: APjAAAUdwwCh+h8kD+heeUsxnrVVS0qQ7vvvp44Lz2lUve18T764At6r
        C9dLOn07mCpvkIY1ZZ405LkWOsxEevmdMiCh
X-Google-Smtp-Source: APXvYqySrOnTGtY7+9DITehe3Meo7s084GaA+6N+nsJP5kacBuLgycbMeZZYgExDf3vDCEP9ZAH+xQ==
X-Received: by 2002:a63:520a:: with SMTP id g10mr17908361pgb.298.1581619930792;
        Thu, 13 Feb 2020 10:52:10 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id c11sm3982890pfo.170.2020.02.13.10.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 10:52:10 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Fri, 14 Feb 2020 00:22:05 +0530
To:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: staging: board: disabled driver
Message-ID: <20200213185205.GA26906@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made some changes in board.h and other files under board to remove the MACRO using conditions. I did git log --oneline "file path" to get the logs, but turned out the driver was disabled. Hence on seeing it's KConfig file I found STAGING_BOARd and searched it in device drivers in menuconfig. I found that OF_ADDRESS-> OF-> X86_INTEL_CE were disabled as well. But I couldn't find X86_INTEL_CE under the device drivers.What should I do about it? Is there a way around or should I look at other drivers than board?
Thanks for your time!
