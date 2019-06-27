Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24067582CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfF0Mq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 08:46:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41800 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0Mq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:46:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so6945855eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QcDk5zUKbz23dkSjNBVXwjq0i8xHM9vtNbHjMMC6vV0=;
        b=Ph8a0a5yHbRPhclO3Pn0KnYkbHmqZJ1TzgavGNPl8lmeqhJTJc84xPfvgYwIEtmpAJ
         SLUBBxlcsWcu+FQLeGK2WBfqjvVNdPyCSw5uxBpm/DHLWwg6ht4aR7x0iOdbABcWIihQ
         wRNHBiJrT+zuLgpTm1MbLIaqKSi2JTrCJHxM7CkX09ypWgFJpJ4b4xqX00fWg+NBj175
         V7xJ+dVSS9ieTZq8jeuaAVG7c45OdqBRFsyCmrAD+BAy/yBT2KC/Homx61Vz7PAGYIeL
         7oTqvW3rLlxDu9ZaKffB5hPvoQHEQthc7VBSVJ0OTK1xXMRCB1wzy+2+JrC9R38OptSn
         mGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcDk5zUKbz23dkSjNBVXwjq0i8xHM9vtNbHjMMC6vV0=;
        b=mrsFsG7MNHZmsyN2D4TumKWLiY2Qh4Xzd/1Lu2MXLL4fzYF/GpumxNjss+UHd2wCIW
         fvL5VqYbwhpH+uM9BhL2PkzBrDoS0WfNzWl0CRYtXoG70T+E0t4lORwNntqr5n/EsSyQ
         zlCbPIXhsozfjdK4SX79Ig6UWy7MKGF3xvQ5ZdO+4t63feZxmeaziufcDzg0T0C56Qr2
         Qacmv1nEdxQxMk04B4k+2huki4OQrgXzjyLnfRcTMxz5da4jxt9xhkWwoKgeMwULQ482
         pusP3mlQeGLuPoW9OB7xjqOzgzkvprElauplvIvUUWpTSabwzFJ7d+4jf8yF9VFMe7kj
         F6wQ==
X-Gm-Message-State: APjAAAX2eu8lh6fd2nvyjcHJ0OCNR7vTRB7agCNeExSQ3c5QvmDeM17N
        8Ld2x7Gy7SXPJBYrtLee5wNcjg==
X-Google-Smtp-Source: APXvYqx8PviEpESGoaGFrEkuGJDnDhMWSIld5rUq0chtQKwTslTti67hACIPECZQNkq5ZBizPpaPOw==
X-Received: by 2002:a50:976d:: with SMTP id d42mr3969822edb.77.1561639586109;
        Thu, 27 Jun 2019 05:46:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c48sm735496edb.10.2019.06.27.05.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 05:46:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2E04A103F66; Thu, 27 Jun 2019 15:46:24 +0300 (+03)
Date:   Thu, 27 Jun 2019 15:46:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 0/6] Enable THP for text section of non-shmem files
Message-ID: <20190627124624.uzu5trpfcdcz5uzz@box>
References: <20190625001246.685563-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-1-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:40PM -0700, Song Liu wrote:
> Please share your comments and suggestions on this.

Looks like a great first step to THP in page cache. Thanks!

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

THP allocation in the fault path and write support are next goals.

-- 
 Kirill A. Shutemov
