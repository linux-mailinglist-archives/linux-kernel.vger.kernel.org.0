Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD7E1449A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 03:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAVCDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 21:03:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40078 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgAVCDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:03:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so2490886pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 18:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e7FwBWIW8IGtpE9uyvgf8eUHJH2AGbivzVpzVQ32h1g=;
        b=mXRfAoPG6gsQGH8Kykj/OE9p6Y3BEqyAjZ36/fFGQmG0goZBr5FysQSt/5rc08WUp2
         uA0Exk/eK3fFyHtQgYEMULf/p5OJIVxBazrY8JkDMQ+X6QpTOQFq4axKKEcegoXE76FD
         Q3tf5ceTt+0b/GotcgOVVqnyua/QyCM4ZY3nk6vYlpNFpjEK6H8yRRFy3sHEoc3rE/HQ
         rbDY9LV6tzK2Sbz33tRTXgwN+ayvNAsmI7fCigbSnLSgnmBQoQwAqhOwx9OwOF0qjR69
         m3cGhcoddJPZWj1VBN//5dToYRb8N4T6rfZ4Lu0uuDvwOU8vFzIdaNN5wIOTzaiaV5Tn
         Ofjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7FwBWIW8IGtpE9uyvgf8eUHJH2AGbivzVpzVQ32h1g=;
        b=UrdZcZBm0bI9a4RIfAZaXG6Ad+5xKxE6baMxWfpUoItSOW/yUgYH3/0KCHllbRLUbw
         socPr6kRqqGd8f7jPiBTtWrKCaepQDqefVb0jRw0UI4YcF7bp2a/qxVLZvri0PshCNSE
         jTKYQw0JAy9glGVPyeEpeOo3c8UII32c+NhcVu/YbY+Wx+wiv8V8QDkndhSvcoCEzIzG
         iM1uR5QHUcxkaWpbJdUXS7oNyYcEf8s5zugahGJARGW6MHNcz3TGG4RBEuAbXvArx+f1
         GS4ZXxcVrzECs9o6uNkpgcAHCZX8nKLNSX860/C2w7SkuJpK3HJt2K84zyqKWXoYuZzP
         Zw8g==
X-Gm-Message-State: APjAAAVyIinmH+zd/bkHfQeihctGZphr9VAcEP9Bg1jT1xR8nnSkPwaH
        0OeeA2ALpCxUzxhfj+4YoJOaDw==
X-Google-Smtp-Source: APXvYqxtLnnOkMqzi99/d09pO1vOn30qGYYwyeZzbV4j3PrOvgJUDqmYarLWlLl55hSUd2jARYLtGg==
X-Received: by 2002:a62:2a49:: with SMTP id q70mr444040pfq.170.1579658616244;
        Tue, 21 Jan 2020 18:03:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q12sm43794842pfh.158.2020.01.21.18.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 18:03:35 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add splice(2) support
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1579649589.git.asml.silence@gmail.com>
 <8bfd9a57bf42cfc10ee7195969058d6da277deed.1579649589.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d43b9d7-209a-2bbf-e2c2-e125e84b46ab@kernel.dk>
Date:   Tue, 21 Jan 2020 19:03:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8bfd9a57bf42cfc10ee7195969058d6da277deed.1579649589.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 5:05 PM, Pavel Begunkov wrote:
> @@ -373,6 +374,15 @@ struct io_rw {
>  	u64				len;
>  };
>  
> +struct io_splice {
> +	struct file			*file_in;
> +	struct file			*file_out;
> +	loff_t __user			*off_in;
> +	loff_t __user			*off_out;
> +	u64				len;
> +	unsigned int			flags;
> +};
> +
>  struct io_connect {
>  	struct file			*file;
>  	struct sockaddr __user		*addr;

Probably just make that len u32 as per previous email.

> @@ -719,6 +730,11 @@ static const struct io_op_def io_op_defs[] = {
>  		.needs_file		= 1,
>  		.fd_non_neg		= 1,
>  	},
> +	[IORING_OP_SPLICE] = {
> +		.needs_file		= 1,
> +		.hash_reg_file		= 1,
> +		.unbound_nonreg_file	= 1,
> +	}
>  };
>  
>  static void io_wq_submit_work(struct io_wq_work **workptr);

I probably want to queue up a reservation for the EPOLL_CTL that I
haven't included yet, but which has been tested. But that's easily
manageable, so no biggy on my end.

> +static bool io_splice_punt(struct file *file)
> +{
> +	if (get_pipe_info(file))
> +		return false;
> +	if (!io_file_supports_async(file))
> +		return true;
> +	return !(file->f_mode & O_NONBLOCK);
> +}
> +
> +static int io_splice(struct io_kiocb *req, struct io_kiocb **nxt,
> +		     bool force_nonblock)
> +{
> +	struct io_splice* sp = &req->splice;
> +	struct file *in = sp->file_in;
> +	struct file *out = sp->file_out;
> +	unsigned int flags = sp->flags;
> +	long ret;
> +
> +	if (force_nonblock) {
> +		if (io_splice_punt(in) || io_splice_punt(out)) {
> +			req->flags |= REQ_F_MUST_PUNT;
> +			return -EAGAIN;
> +		}
> +		flags |= SPLICE_F_NONBLOCK;
> +	}
> +
> +	ret = do_splice(in, sp->off_in, out, sp->off_out, sp->len, flags);
> +	if (force_nonblock && ret == -EAGAIN)
> +		return -EAGAIN;
> +
> +	io_put_file(req->ctx, out, (flags & IOSQE_SPLICE_FIXED_OUT));
> +	io_cqring_add_event(req, ret);
> +	if (ret != sp->len)
> +		req_set_fail_links(req);
> +	io_put_req_find_next(req, nxt);
> +	return 0;
> +}

This looks good. And this is why the put_file() needs to take separate
arguments...

> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 57d05cc5e271..f234b13e7ed3 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -23,8 +23,14 @@ struct io_uring_sqe {
>  		__u64	off;	/* offset into file */
>  		__u64	addr2;
>  	};
> -	__u64	addr;		/* pointer to buffer or iovecs */
> -	__u32	len;		/* buffer size or number of iovecs */
> +	union {
> +		__u64	addr;		/* pointer to buffer or iovecs */
> +		__u64	off_out;
> +	};
> +	union {
> +		__u32	len;	/* buffer size or number of iovecs */
> +		__s32	fd_out;
> +	};
>  	union {
>  		__kernel_rwf_t	rw_flags;
>  		__u32		fsync_flags;
> @@ -37,10 +43,12 @@ struct io_uring_sqe {
>  		__u32		open_flags;
>  		__u32		statx_flags;
>  		__u32		fadvise_advice;
> +		__u32		splice_flags;
>  	};
>  	__u64	user_data;	/* data to be passed back at completion time */
>  	union {
>  		__u16	buf_index;	/* index into fixed buffers, if used */
> +		__u64	splice_len;
>  		__u64	__pad2[3];
>  	};
>  };

Not a huge fan of this, also mean splice can't ever used fixed buffers.
Hmm...

> @@ -67,6 +75,9 @@ enum {
>  /* always go async */
>  #define IOSQE_ASYNC		(1U << IOSQE_ASYNC_BIT)
>  
> +/* op custom flags */
> +#define IOSQE_SPLICE_FIXED_OUT	(1U << 16)
> +

I don't think it's unreasonable to say that if you specify
IOSQE_FIXED_FILE, then both are fixed. If not, then none of them are.
What do you think?

-- 
Jens Axboe

