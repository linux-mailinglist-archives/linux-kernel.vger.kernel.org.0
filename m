Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED30B908F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfITNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 09:21:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47098 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfITNVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:21:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3so6334930edw.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KjJoWbq/s+cOzpzxNWtJ0sKe7VWYvgH4sW4C23WObhw=;
        b=fxPVgGWKizyrOEFDCOd/qx1Fk29RR580Y2UsEIfskOD2uHubzUmk+Ay8eOxuaR/uSv
         vY1gF357MrawvE8daiEyUwrNqC3FzGuT0TOXGR56mW8CDQUSKkDjZDAdv4TQvTH6zJ9J
         ZDVyLyo/01zn+lu7DYEtPfl+M9xTLDV/6+CBeKxQr0BL6UW0NjuZcLkL8o6yyr+UuZIR
         0WikGrLbRc6EOmmStWm4t5Tnbi1yDCxPRLuIFbTGpv1oRS5VeRwQQw5Szfmsrc7T32+n
         nH7nP1QrNHpdeYKRXYTrEEfesfO20P+i7ZoD8t8xTQR+KqvIYUdnZfZFv2+SS6kStPHT
         17qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KjJoWbq/s+cOzpzxNWtJ0sKe7VWYvgH4sW4C23WObhw=;
        b=m+CZAhOo2gDMcFU2FoikHPhyIRJFaVwxjZf6KvP18JPHn4q75jG+PwuitLX/cB+LKR
         PRknAm5+ZWXogL4U0lWfqXui05G9652r1UZzN8pWMsCfC+iX54bb3CY4HOmX2rqBpkmH
         I+7WX1rK7fDcHq7FLPhRHu3AbmLXmKIlskoMW336sldY/QU+ggG1bRX4SQP1yB0cXXCU
         Obch9/zrGB7t4f0SUwO7JB9s1udbXGIgPFvKTWD3Eb81J1q7RkLlXEh7SX4aJQ0U1Ijw
         hpfAkEOOF3SgF+Y4zcsdq0FUtBWktUPkUPAAP+7+eMxUEMlcg1yNcdZ3tirM9abYW7/v
         YfOQ==
X-Gm-Message-State: APjAAAV3lPrrYxBRUAmyKV7YkU5xbF5EgSx3ZwY4qz6i+/2/trBAaXW0
        ZOx11G88MR0wCdBV852nt7gZmA==
X-Google-Smtp-Source: APXvYqxsduZAapMWzwVstniHqOLgxY6tQ8bBUkyTVS6n0fTA0P4mN1lEnIS0KNudn6P9i9Ko1H475g==
X-Received: by 2002:a50:f00c:: with SMTP id r12mr22051477edl.274.1568985675740;
        Fri, 20 Sep 2019 06:21:15 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a22sm226608ejs.17.2019.09.20.06.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 06:21:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AB09D1006ED; Fri, 20 Sep 2019 16:21:14 +0300 (+03)
Date:   Fri, 20 Sep 2019 16:21:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] mm, memcg: assign shrinker_map before kvfree
Message-ID: <20190920132114.ofzphp53vqqjb3fs@box>
References: <20190920122907.GG2507@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920122907.GG2507@uranus.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 03:29:07PM +0300, Cyrill Gorcunov wrote:
> Currently there is a small gap between fetching pointer, calling
> kvfree and assign its value to nil. In current callgraph it is
> not a problem (since memcg_free_shrinker_maps is running from
> memcg_alloc_shrinker_maps and mem_cgroup_css_free only) still
> this looks suspicious and we can easily eliminate the gap at all.

With this logic it will still look suspicious since you don't wait a grace
period before freeing the map.

-- 
 Kirill A. Shutemov
