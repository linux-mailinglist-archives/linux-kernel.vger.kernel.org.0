Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE734F825
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFVUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 16:22:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44708 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 16:22:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so4654982plr.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1w4upBhO9u5DrCydQoLXXnUxv1WXapfYDD1jk9PIDQA=;
        b=OOOVQJTXjb56HyWy+ezfShBHwUM1Mo4Vj0K02GtwEpgbGBm89AXs7U9eg6dsqPNjZ1
         PMavEq93wzBvgfsZw6cViARLTasvbLlruNvNLvZhcdW4St16utw5n9h/UFVZn/WVjhGI
         DdXdmnN/RhV1S7FgweNpZFokXOl0F1RxYo5Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1w4upBhO9u5DrCydQoLXXnUxv1WXapfYDD1jk9PIDQA=;
        b=JeAVi0IjugrmZ46bSDt8Kjsh5UxZURYtT1YMYTxURUNS6O3F9zc7OMDJqWUD4pXMCV
         alAXJesA8ig8ui2ZxaZhAGqHjFRYPWmpEU/udA3ts1zOvyFcRVKKcImL3GSCXNkfqQSB
         +hQjr1HnNUhU/bev5NDgjAGfMWge6OLpO5ExScFTZXq8KpOJlK6SlZcSU72iaxjtSTrg
         NYqB8Bmb9MVEtbfMWyxZwpMLUts/TNpiKDFzBGMnktkqEwCdoOB3tiPJqx/CjKpQuTQI
         hqAg3qqCYRmEWGB4FjbtF8seD5NKv0O9IJ85xEnzTuofZYngyPxWVTMBmp4fqtNla2EZ
         3wjw==
X-Gm-Message-State: APjAAAXzP2moq2xuVyBd7/zQXDzumVlWw69dkDrK/5/J7MNC8uikAi1I
        6fENtY64SSHceEcnoyP8ntkh8w==
X-Google-Smtp-Source: APXvYqwPSy1JJwzKBw7YFhSjIjET++vlOZO2iqmz6J9vOjD7VZoKy8n6adF2zxwhH17r5CEaW+Y5Mg==
X-Received: by 2002:a17:902:7894:: with SMTP id q20mr127674761pll.339.1561234977830;
        Sat, 22 Jun 2019 13:22:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m8sm5325462pjs.22.2019.06.22.13.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 13:22:57 -0700 (PDT)
Date:   Sat, 22 Jun 2019 13:22:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <201906221320.5BFC134713@keescook>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622190058.GD5343@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 03:00:58PM -0400, J. Bruce Fields wrote:
> The logic around ESCAPE_NP and the "only" string is really confusing.  I
> started assuming I could just add an ESCAPE_NONASCII flag and stick "
> and \ into the "only" string, but it doesn't work that way.

Yeah, if ESCAPE_NP isn't specified, the "only" characters are passed
through. It'd be nice to have an "add" or a clearer way to do actual
ctype subsets, etc. If there isn't an obviously clear way to refactor
it, just skip it for now and I'm happy to ack your original patch. :)


-- 
Kees Cook
